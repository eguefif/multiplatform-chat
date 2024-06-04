import 'package:web_socket_channel/web_socket_channel.dart';

const serverUrl = 'ws://localhost:3000';

class SocketService {
  late WebSocketChannel _channel;

  void initConnection() {
    _channel = WebSocketChannel.connect(Uri.parse(serverUrl));
  }

  Stream<dynamic> getNextMessage() async* {
    await for (dynamic message in _channel.stream) {
      yield message;
    }
  }
}
