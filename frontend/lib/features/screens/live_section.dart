import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/features/features.dart';
import 'package:frontend/widgets/widgets.dart';

class LiveSection extends StatelessWidget {
  final GlobalKey liveKey;
  final GlobalKey heartRateKey;
  final GlobalKey respirationRateKey;
  final GlobalKey postureKey;

  const LiveSection({
    super.key,
    required this.liveKey,
    required this.heartRateKey,
    required this.respirationRateKey,
    required this.postureKey,
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

          Container(
            key: respirationRateKey,
            child: RespirationWidget(
              respirationRate: provider.liveData?.respirationRate,
            ),
          ),

          Container(
            key: postureKey,
            child: PostureWidget(
              posture: postureFromString(provider.liveData?.posture.name),
            ),
          ),

        ],
      ),
    );
  }
}