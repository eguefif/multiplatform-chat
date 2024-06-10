import asyncio
import json
from enum import Enum

import websockets

from client import Client
from conversation import ConversationHandler


class Command(Enum):
    USERNAME = "username"
    MESSAGE = "message"
    CONTENT = "content"
    CLIENTLIST = "clientlist"
    RECIPIENT = "recipient"


class Server:
    def __init__(self, host="0.0.0.0", port=3000):
        self.clients = set()
        self.host = host
        self.port = port
        self.current_id = 0
        self.conversation_handler = ConversationHandler()

    async def handler_client(self, websocket):
        new_client = await self.register_client(websocket)
        if not new_client:
            return
        await self.send_clients_list()
        await asyncio.gather(self.consumer_handler(new_client))
        try:
            await websocket.wait_closed()
        finally:
            await self.remove_client(new_client)

    async def register_client(self, websocket):
        try:
            username_cmd = await websocket.recv()
        except Exception:
            return False
        message = json.loads(username_cmd)
        if not self.checkIdentifyCommand(message):
            return False
        username = message[Command.USERNAME.value]
        if self.is_username_taken(username):
            return False
        new_client_id = self.current_id
        self.current_id += 1
        new_client = Client(websocket, username, new_client_id)
        await self.remove_client(new_client)
        self.clients.add(new_client)
        print(f"New client connected: {username}")
        return new_client

    def is_username_taken(self, username):
        for client in self.clients:
            if client.username == username:
                return True
        return False

    def checkIdentifyCommand(self, message):
        if (
            isinstance(message, dict)
            and Command.USERNAME.value in message.keys()
        ):
            return True
        return False

    async def send_clients_list(self):
        clients_list = [client.username for client in self.clients]
        if len(clients_list) == 0:
            return
        clients_list = {
            "command": Command.CLIENTLIST.value,
            "content": clients_list,
        }
        packet = json.dumps(clients_list)
        for client in self.clients:
            if not await self.send_message(packet, client):
                return

    async def send_message(self, packet, client):
        try:
            await client.websocket.send(packet)
        except Exception:
            await self.send_clients_list()
            return False
        return True

    async def remove_client(self, client):
        if client in self.clients:
            self.clients.remove(client)
            print(f"Client {client.username} disconnected")
            await self.send_clients_list()

    async def consumer_handler(self, client):
        async for message in client.websocket:
            if not await self.consumer(message, client):
                return

    async def consumer(self, message, client):
        message_loaded = json.loads(message)
        try:
            recipient = message_loaded[Command.RECIPIENT.value]
            content = message_loaded[Command.CONTENT.value]
        except Exception:
            await self.remove_client(client)
            return False

        if not self.is_recipient(recipient):
            return
        conversation = self.conversation_handler.updateConversation(
            content, client.username, recipient
        )
        if conversation:
            await self.send_conversation(conversation)
        return True

    def is_recipient(self, recipient):
        for client in self.clients:
            if client.username == recipient:
                return True
        return False

    async def send_conversation(self, conversation):
        message = {"command": "message", "content": conversation.messages}
        packet = json.dumps(message)
        for client in self.clients:
            if conversation.isPartOf(client.username):
                await self.send_message(packet, client)

    async def run(self):
        print("Server running on ws://{}:{}".format(self.host, self.port))
        async with websockets.serve(self.handler_client, self.host, self.port):
            await asyncio.Future()
