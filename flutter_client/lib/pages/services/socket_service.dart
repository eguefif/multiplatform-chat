import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

const serverUrl = 'ws://localhost:3000';

class SocketService {
  late WebSocketChannel _channel;

  Future<void> initConnection() async {
    _channel = WebSocketChannel.connect(Uri.parse(serverUrl));
    await _channel.ready;
  }

  void dispose() {
    _channel.sink.close();
  }

  void sendUsername(String username) {
    final packet = {
      'username': username,
    };
    _channel.sink.add(jsonEncode(packet));
  }

  void sendMessage(String message, String recipient) {
    String packet = getMessagePacket(message, recipient);
    _channel.sink.add(packet);
  }

  String getMessagePacket(String message, String recipient) {
    final packet = {
      'message': message,
      'recipient': recipient,
    };
    return jsonEncode(packet);
  }
}
