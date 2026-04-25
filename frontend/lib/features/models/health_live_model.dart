import 'models.dart';

class HealthLiveModel {
  final int? heartRate;
  final int? respirationRate;
  final Posture posture;
  final DateTime? timestamp;

  HealthLiveModel({
    this.heartRate,
    this.respirationRate,
    required this.posture,
    this.timestamp,
  });

  factory HealthLiveModel.fromJson(Map<String, dynamic> json) {
    return HealthLiveModel(
      heartRate: json["heart_rate"],
      respirationRate: json["respiration_rate"],
      posture: postureFromString(json["posture"]),
      timestamp: DateTime.tryParse(json["timestamp"] ?? ""),
    );
  }
}