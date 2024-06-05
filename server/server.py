import asyncio
from enum import Enum
import json
from websockets.server import serve

from client import Client
from conversation import ConversationHandler

class Command(Enum):
    USERNAME = "username"
    MESSAGE = "message"
    CONTENT = "content"
    CLIENTLIST = "clientlist"
    RECIPIENT = "recipient"


class Server:
    def __init__(self, host = "localhost", port = 3000):
        self.clients = []
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

   
    async def register_client(self, websocket):
        username_cmd = await websocket.recv()
        message = json.loads(username_cmd)
        if not self.checkIdentifyCommand(message):
            return False
        username = message[Command.USERNAME.value]
        new_client_id = self.current_id
        self.current_id += 1
        new_client = Client(websocket, username, new_client_id)
        self.clients.append(new_client)
        print(f"New client connected: {username}")
        return new_client

    def checkIdentifyCommand(self, message):
        if isinstance(message, dict) and Command.USERNAME.value in message.keys():
            return True
        return False

    async def send_clients_list(self):
        clients_list = [client.username for client in self.clients]
        if (len(clients_list) == 0):
            return
        clients_list = {Command.CLIENTLIST.value: clients_list}
        packet = json.dumps(clients_list)
        for client in self.clients:
            await client.websocket.send(packet)

    async def consumer_handler(self, client):
        async for message in client.websocket:
            await self.consumer(message, client)
    
    async def consumer(self, message, client):
        message_loaded = json.loads(message)
        recipient = message_loaded[Command.RECIPIENT.value]
        content = message_loaded[Command.CONTENT.value]
        if not self.is_recipient(recipient):
            return
        conversation = self.conversation_handler.updateConversation(content, client.username, recipient)
        if conversation:
            await self.send_conversation(conversation)

    def is_recipient(self, recipient):
        for client in self.clients:
            if client.username == recipient:
                return True
        return False

    async def send_conversation(self, conversation):
        for client in self.clients:
            if conversation.isPartOf(client.username):
                await client.websocket.send(conversation.getSerializedJson())

    async def run(self):
        print("Server running on ws://{}:{}".format(self.host, self.port))
        async with serve(self.handler_client, self.host, self.port):
            await asyncio.Future()