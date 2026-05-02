class HourlyData {
  final int hour;
  final double avgHeartRate;
  final double avgRespirationRate;

  HourlyData({
    required this.hour,
    required this.avgHeartRate,
    required this.avgRespirationRate,
  });

  factory HourlyData.fromJson(Map<String, dynamic> json) {
    return HourlyData(
      hour: json["hour"],
      avgHeartRate: (json["avg_heart_rate"] ?? 0).toDouble(),
      avgRespirationRate: (json["avg_respiration_rate"] ?? 0).toDouble(),
    );
  }
}


class TodayAverage {
  final double heart;
  final double resp;
  final int totalRecords;

  TodayAverage({
    required this.heart,
    required this.resp,
    required this.totalRecords,
  });

  factory TodayAverage.fromJson(Map<String, dynamic> json) {
    return TodayAverage(
      heart: (json["avg_heart_rate"] ?? 0).toDouble(),
      resp: (json["avg_respiration_rate"] ?? 0).toDouble(),
      totalRecords: json["total_records"] ?? 0,
    );
  }
}

class SummaryModel {
  final int min;
  final int max;

  SummaryModel({required this.min, required this.max});

  factory SummaryModel.fromJson(Map<String, dynamic> json) {
    return SummaryModel(
      min: json["min_heart_rate"] ?? 0,
      max: json["max_heart_rate"] ?? 0,
    );
  }
}

class PostureStats {
  final double supine;
  final double prone;
  final double left;
  final double right;

  PostureStats({
    required this.supine,
    required this.prone,
    required this.left,
    required this.right,
  });

  factory PostureStats.fromJson(Map<String, dynamic> json) {
    double parse(dynamic v) =>
        double.tryParse(v.toString()) ?? 0;

    return PostureStats(
      supine: parse(json["supine"]),
      prone: parse(json["prone"]),
      left: parse(json["left"]),
      right: parse(json["right"]),
    );
  }
}