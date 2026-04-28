import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontend/features/features.dart';
import '../../core/core.dart';

class RealtimeProvider extends ChangeNotifier {
  final RealtimeService _service = RealtimeService();

  HealthLiveModel? liveData;
  SocketStatus status = SocketStatus.connecting;

  StreamSubscription? _dataSub;
  StreamSubscription? _statusSub;

  void start() {
    _service.connect();

    _dataSub = _service.getHealthStream().listen((data) {
      liveData = data;
      notifyListeners();
    });

    _statusSub = _service.statusStream.listen((newStatus) {
      status = newStatus;
      notifyListeners();
    });
  }

  void stop() {
    _dataSub?.cancel();
    _statusSub?.cancel();
    _service.disconnect();
  }
}