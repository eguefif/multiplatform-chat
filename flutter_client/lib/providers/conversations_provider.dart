import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'conversations_provider.g.dart';

@riverpod
class ConversationsNotifier extends _$ConversationsNotifier {
  @override
  ConversationsModel build() {
    return ConversationsModel();
  }

  void updateConversation(List<Map<String, String>> content, String username) {
    String? recipient = _getRecipient(content, username);
    if (recipient != null) {
      Conversation conversation = Conversation(
        recipient: recipient,
        messages: content
            .map<Message>((message) => Message.fromJson(message))
            .toList(),
      );
      if (state.isRecipient(recipient)) {
        state.conversations
            .removeWhere((conversation) => conversation.recipient == recipient);
      }
      state.conversations.add(conversation);
    }
  }

  String? _getRecipient(List<Map<String, String>> content, String username) {
    if (content.isNotEmpty) {
      var message = content[0];
      return message['src'] == username ? message['recipient'] : message['src'];
    }
    return null;
  }
}

class ConversationsModel {
  List<Conversation> conversations;

  ConversationsModel({this.conversations = const []});

  String getConversation(String recipient) {
    Conversation conversation = conversations
        .firstWhere((conversation) => conversation.recipient == recipient);
    return conversation.getConversationStr();
  }

  bool isRecipient(String recipient) {
    return conversations
        .any((conversation) => conversation.recipient == recipient);
  }
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

  String getConversationStr() {
    if (messages.isEmpty) {
      return "No messages yet";
    }
    return messages
        .map((message) => "${message.src}: ${message.message}")
        .join("\n");
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
