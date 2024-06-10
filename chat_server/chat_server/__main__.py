import asyncio

from server import Server

if __name__ == "__main__":
    server = Server("0.0.0.0", 3001)
    asyncio.run(server.run())
