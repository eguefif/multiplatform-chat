import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter_client/providers/user_information_provider.dart';

part 'websocket_provider.g.dart';

const serverUrl = 'ws://10.98.6.88:3001/';

@riverpod
Stream<dynamic> webSocket(WebSocketRef ref) async* {
  var ws = WebSocketChannel.connect(Uri.parse(serverUrl));
  String username = ref.read(userInformationProvider).username;
  Map<String, String> message = {
    'username': username,
  };
  ws.sink.add(jsonEncode(message));
  await for (var message in ws.stream) {
    yield message;
  }
}
