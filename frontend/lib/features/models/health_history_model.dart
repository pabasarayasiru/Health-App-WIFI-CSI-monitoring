import 'models.dart';

class HealthHistoryModel {
  final int? heartRate;
  final int? respirationRate;
  final Posture posture;
  final DateTime? timestamp;

  HealthHistoryModel({
    this.heartRate,
    this.respirationRate,
    required this.posture,
    this.timestamp,
  });

  factory HealthHistoryModel.fromJson(Map<String, dynamic> json) {
    return HealthHistoryModel(
      heartRate: json["heart_rate"],
      respirationRate: json["respiration_rate"],
      posture: postureFromString(json["posture"]),
      timestamp: DateTime.tryParse(json["timestamp"] ?? ""),
    );
  }
}