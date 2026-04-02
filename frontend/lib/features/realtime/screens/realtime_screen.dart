import 'package:flutter/material.dart';
import '../services/realtime_service.dart';

class RealtimeScreen extends StatefulWidget {
  const RealtimeScreen({super.key});

  @override
  State<RealtimeScreen> createState() => _RealtimeScreenState();
}

class _RealtimeScreenState extends State<RealtimeScreen> {
  final service = RealtimeService();

  @override
  void initState() {
    super.initState();
    service.connect();
  }

  @override
  void dispose() {
    service.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Live Health Data")),
      body: StreamBuilder(
        stream: service.getHealthStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("❤️ Heart Rate: ${data.heartRate}"),
              Text("🌬 Respiration: ${data.respiration}"),
              Text("🧍 Posture: ${data.posture}"),
            ],
          );
        },
      ),
    );
  }
}
