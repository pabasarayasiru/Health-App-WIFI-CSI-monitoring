class HealthLiveModel {
  final int heartRate;
  final int respiration;
  final String posture;

  HealthLiveModel({
    required this.heartRate,
    required this.respiration,
    required this.posture,
  });

  factory HealthLiveModel.fromJson(Map<String, dynamic> json) {
    return HealthLiveModel(
      heartRate: json['heartRate'],
      respiration: json['respiration'],
      posture: json['posture'],
    );
  }
}
