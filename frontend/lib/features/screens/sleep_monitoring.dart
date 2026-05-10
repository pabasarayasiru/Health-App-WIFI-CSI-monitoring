import 'package:flutter/material.dart';
import 'package:frontend/features/features.dart';
import 'package:provider/provider.dart';
import 'package:frontend/widgets/widgets.dart';

class SleepMonitoring extends StatelessWidget {

  final GlobalKey sleepSectionKey;

  const SleepMonitoring({
    super.key,
    required this.sleepSectionKey,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
        key: sleepSectionKey,
        padding: const EdgeInsets.all(16),
        child :Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderTopic(topic: "Sleep Monitoring"),
            SizedBox(height: 12,),
            Center(
              child: Text(
                  "Currently, Not implemented",
                  style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.normal,
                  )
              ),
            ),
          ],
        )
    );
  }
}