import 'dart:convert';
import '../../core/core.dart';
import 'package:frontend/features/features.dart';

class RealtimeService {
  final WebSocketService _socketService = WebSocketService();

  Stream<HealthLiveModel> getHealthStream() {
    return _socketService.stream.map((message) {
      final data = jsonDecode(message);

      if (data["type"] == "health_data") {
        return HealthLiveModel.fromJson(data["payload"]);
      } else {
        throw Exception("Unknown message type");
      }
    });
  }

  Stream<SocketStatus> get statusStream =>
      _socketService.statusStream;

  void connect() {
    _socketService.connect(ApiConstants.socketUrl);
  }

  void disconnect() {
    _socketService.disconnect();
  }
}