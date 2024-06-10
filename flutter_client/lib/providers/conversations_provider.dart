import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'conversations_provider.g.dart';

@riverpod
class Conversations extends _$Conversations {
  @override
  ConversationsModel build() {
    return ConversationsModel(currentRecipient: "", conversations: [
      Conversation(recipient: "Robert", messages: [
        Message(recipient: "Robert", src: "Emmanuel", message: "Hello"),
        Message(recipient: "Emmanuel", src: "Robert", message: "Hello you"),
        Message(
            recipient: "Robert",
            src: "Emmanuel",
            message: "How are your doing?"),
        Message(
            recipient: "Robert",
            src: "Emmanuel",
            message: "I hope you are doing well"),
      ])
    ]);
  }

  void changeCurrentRecipient(String recipient) {
    state = ConversationsModel(
        currentRecipient: recipient, conversations: state.conversations);
  }
}

class ConversationsModel {
  String currentRecipient;
  List<Conversation> conversations;

  ConversationsModel(
      {this.currentRecipient = "", this.conversations = const []});
}

class Conversation {
  String recipient;
  List<Message> messages;

  Conversation({required this.recipient, required this.messages});

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      recipient: json['recipient'],
      messages: json['messages']
          .map<Message>((message) => Message.fromJson(message))
          .toList(),
    );
  }
}

class Message {
  String src;
  String recipient;
  String message;

  Message({required this.src, required this.recipient, required this.message});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      src: json['src'],
      recipient: json['recipient'],
      message: json['message'],
    );
  }
}
