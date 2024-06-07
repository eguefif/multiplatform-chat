import asyncio
from server import Server

async def main():
    server = Server("0.0.0.0", 3001)  
    await server.run()

if __name__ == "__main__":
    asyncio.run(main())