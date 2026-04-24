import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../constants/api_constants.dart';

class WebSocketService {
  late WebSocketChannel channel;

  void connect() {
    channel = WebSocketChannel.connect(Uri.parse(ApiConstants.socketUrl));
  }

  Stream<Map<String, dynamic>> get stream {
    return channel.stream.map((event) {
      return jsonDecode(event);
    });
  }

  void disconnect() {
    channel.sink.close();
  }
}
