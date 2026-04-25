import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/features/features.dart';
import 'package:frontend/widgets/widgets.dart';

class LiveSection extends StatelessWidget {
  final GlobalKey liveKey;
  final GlobalKey heartRateKey;

  const LiveSection({
    super.key,
    required this.liveKey,
    required this.heartRateKey,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RealtimeProvider>();

    return Container(
      key: liveKey,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderTopic(topic: "Live Result"),

          Container(
            key: heartRateKey,
            child: HeartRateWidget(
              heartRate: provider.liveData?.heartRate,
            ),
          ),

          const SizedBox(height: 10),

          Card(
            elevation: 5,
            child: ListTile(
              title: Text(
                  "Heart Rate: ${provider.liveData?.heartRate ?? '--'}"),
              subtitle: Text(
                  "Respiration: ${provider.liveData?.respirationRate ?? '--'}"),
              trailing:
              Text(provider.liveData?.posture.name ?? "--"),
            ),
          ),
        ],
      ),
    );
  }
}