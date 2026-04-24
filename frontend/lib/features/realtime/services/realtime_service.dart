import '../../../core/network/websocket_service.dart';
import '../models/health_live_model.dart';

class RealtimeService {
  final WebSocketService socketService = WebSocketService();

  void connect() {
    socketService.connect();
  }

  Stream<HealthLiveModel> getHealthStream() {
    return socketService.stream.map((data) {
      return HealthLiveModel.fromJson(data);
    });
  }

  void disconnect() {
    socketService.disconnect();
  }
}
