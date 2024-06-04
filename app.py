import asyncio
from server import Server

async def main():
    server = Server("localhost", 8765)  
    await server.run()

if __name__ == "__main__":
    asyncio.run(main())