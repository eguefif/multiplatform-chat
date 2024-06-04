import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'websocket_pod.g.dart';

const serverUrl = 'ws://localhost:3000';

@riverpod
class WebsocketPod extends _$WebsocketPod {
  late WebSocketChannel channel;

  @override
  void build() {
    channel = WebSocketChannel.connect(Uri.parse(serverUrl));
  }
}
