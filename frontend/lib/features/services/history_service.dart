import 'package:frontend/features/features.dart';

class HistoryService {
  static List<HealthHistoryModel> getFakeHistory() {
    return List.generate(20, (index) {
      return HealthHistoryModel(
        heartRate: 70 + index,
        respirationRate: 15 + (index % 5),
        posture: postureFromString("prone"),
        timestamp: DateTime.now().subtract(Duration(minutes: index * 5)),
      );
    });
  }
}
