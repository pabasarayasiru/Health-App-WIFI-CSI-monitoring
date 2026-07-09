import 'models.dart';

class HealthLiveModel {
  final double? heartRate;
  final double? respirationRate;
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
      heartRate: (json["heart_rate"] as num?)?.toDouble(),
      respirationRate: (json["respiration_rate"] as num?)?.toDouble(),
      posture: postureFromString(json["posture"]),
      timestamp: DateTime.tryParse(json["timestamp"] ?? ""),
    );
  }
}