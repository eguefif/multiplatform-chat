class ConversationHandler:
    def __init__(self):
        self.conversations = []

    def updateConversation(self, message, src, destination):
        for conversation in self.conversations:
            if conversation.isBetween(src, destination):
                conversation.addMessage(message, src)
                return conversation
        new_conversation = Conversation(src, destination)
        new_conversation.addMessage(message, src)
        self.conversations.append(new_conversation)
        return new_conversation


class Conversation:
    def __init__(self, user1, user2):
        self.user1 = user1
        self.user2 = user2
        self.messages = []

    def isBetween(self, user1, user2):
        return (self.user1 == user1 and self.user2 == user2) or (
            self.user1 == user2 and self.user2 == user1
        )

    def addMessage(self, message, src):
        recipient = self.user1 if src == self.user2 else self.user2
        self.messages.append(
            {"src": src, "recipient": recipient, "message": message}
        )

    def isPartOf(self, user):
        return self.user1 == user or self.user2 == user

    def __str__(self):
        return f"Conversation between {self.user1} and {self.user2} with messages: {self.messages}"
