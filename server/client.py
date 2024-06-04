class Client:
    def __init__(self, websocket, username, user_id):
        self.websocket = websocket
        self.username = username
        self.friends = []
        self.id = user_id