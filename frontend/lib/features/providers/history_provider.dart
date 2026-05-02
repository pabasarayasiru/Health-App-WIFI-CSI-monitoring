import 'package:flutter/material.dart';
import 'package:frontend/features/features.dart';

class HistoryProvider extends ChangeNotifier {
  final _service = HistoryService();

  List<HourlyData> hourly = [];
  TodayAverage? today;
  PostureStats? posture;

  DateTime selectedDate = DateTime.now();
  bool isLoading = false;

  Future<void> loadByDate() async {
    isLoading = true;
    notifyListeners();

    try {
      final dateStr =
          "${selectedDate.year.toString().padLeft(4, '0')}-"
          "${selectedDate.month.toString().padLeft(2, '0')}-"
          "${selectedDate.day.toString().padLeft(2, '0')}";

      print("Selected Date: $dateStr");

      final data = await _service.getAnalytics(dateStr);

      // DAILY
      today = TodayAverage.fromJson(data["daily"]);

      // HOURLY
      hourly = (data["hourly"] as List)
          .map((e) => HourlyData.fromJson(e))
          .toList();

      // POSTURE
      posture = PostureStats.fromJson(data["posture"]);

      print("Hourly count: ${hourly.length}");
    } catch (e) {
      print("Analytics error: $e");
    }

    isLoading = false;
    notifyListeners();
  }
}