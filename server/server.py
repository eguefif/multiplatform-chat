import asyncio
from conversation import ConversationHandler
from websockets.server import serve
from client import Client

class Server:
    def __init__(self, host = "localhost", port = 8765):
        self.clients = []
        self.host = host
        self.port = port
        self.current_id = 0
        self.conversation_handler = ConversationHandler()

    async def handler_client(self, websocket):
        new_client = await self.register_client(websocket)
        if not new_client:
            return
        await self.send_clients_list(new_client)
        await asyncio.gather(self.consumer_handler(new_client))

    def checkIdentifyCommand(self, cmd):
        splits = cmd.split(" ")
        if splits[0] == "username" and len(splits) == 2:
            return True
        return False

    async def register_client(self, websocket):
        usernameCmd = await websocket.recv()
        if not self.checkIdentifyCommand(usernameCmd):
            return False
        username = usernameCmd.split(" ")[1]
        new_client_id = self.current_id
        self.current_id += 1
        new_client = Client(websocket, username, new_client_id)
        self.clients.append(new_client)
        return new_client
        
    async def send_clients_list(self, new_client):
        clients_username = [client.username for client in self.clients if client.username != new_client.username]
        if (len(clients_username) == 0):
            return
        clients_list = "clients: " + " ".join(clients_username)
        await new_client.websocket.send(clients_list)

    async def consumer_handler(self, client):
        async for message in client.websocket:
            await self.consumer(message, client)
    
    async def consumer(self, message, client):
        destination = message.split(" ")[0]
        if not self.is_destination(destination):
            return
        message_part = " ".join(message.split(" ")[1:])
        conversation = self.conversation_handler.updateConversation(message_part, client.username, destination)
        if conversation:
            await self.send_conversation(conversation)

    def is_destination(self, destination):
        for client in self.clients:
            if client.username == destination:
                return True
        return False

    async def send_conversation(self, conversation):
        for client in self.clients:
            if conversation.isPartOf(client.username):
                await client.websocket.send(conversation.getSerializedJson())

    async def run(self):
        async with serve(self.handler_client, self.host, self.port):
            await asyncio.Future()