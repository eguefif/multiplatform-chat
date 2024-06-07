import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'websocket_provider.g.dart';

const serverUrl = 'ws://10.98.6.88:3001/';

@riverpod
Stream<dynamic> webSocket(WebSocketRef ref) async* {
  var ws = WebSocketChannel.connect(Uri.parse(serverUrl));
  Map<String, String> message = {
    'username': 'Emmanuel',
  };
  ws.sink.add(jsonEncode(message));
  await for (var message in ws.stream) {
    yield message;
  }
}
