import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'websocket_provider.g.dart';

const serverUrl = 'ws://localhost:3000';

@riverpod
Stream<dynamic> webSocket(WebSocketRef ref) {
  var ws = WebSocketChannel.connect(Uri.parse(serverUrl));
  return ws.stream;
}
