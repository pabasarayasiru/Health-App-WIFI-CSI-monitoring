import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

enum SocketStatus { connecting, connected, disconnected, error }

class WebSocketService {
  WebSocketChannel? _channel;

  final _controller = StreamController<dynamic>.broadcast();
  final _statusController = StreamController<SocketStatus>.broadcast();

  Stream<dynamic> get stream => _controller.stream;
  Stream<SocketStatus> get statusStream => _statusController.stream;

  bool _isConnected = false;

  void connect(String url) {
    _statusController.add(SocketStatus.connecting);

    try {
      _channel = WebSocketChannel.connect(Uri.parse(url));
      _isConnected = true;

      _statusController.add(SocketStatus.connected);

      _channel!.stream.listen(
            (message) {
          _controller.add(message);
        },
        onError: (error) {
          _statusController.add(SocketStatus.error);
          _reconnect(url);
        },
        onDone: () {
          _isConnected = false;
          _statusController.add(SocketStatus.disconnected);
          _reconnect(url);
        },
      );
    } catch (e) {
      _statusController.add(SocketStatus.error);
      _reconnect(url);
    }
  }

  void _reconnect(String url) {
    if (!_isConnected) {
      Future.delayed(const Duration(seconds: 3), () {
        connect(url);
      });
    }
  }

  void send(dynamic data) {
    if (_isConnected) {
      _channel?.sink.add(jsonEncode(data));
    }
  }

  void disconnect() {
    _isConnected = false;
    _channel?.sink.close();
    _statusController.add(SocketStatus.disconnected);
  }

  void dispose() {
    _controller.close();
    _statusController.close();
  }
}
