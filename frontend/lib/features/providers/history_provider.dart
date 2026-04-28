import 'package:flutter/material.dart';
import 'package:frontend/features/features.dart';

class HistoryProvider extends ChangeNotifier {
  List<HealthHistoryModel> history = [];

  void loadFakeHistory() {
    history = HistoryService.getFakeHistory();
    notifyListeners();
  }
}