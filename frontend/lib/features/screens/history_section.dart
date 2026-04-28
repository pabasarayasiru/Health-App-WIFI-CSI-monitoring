import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/features/features.dart';
import 'package:frontend/widgets/widgets.dart';

class HistorySection extends StatelessWidget {
  final GlobalKey historyKey;

  const HistorySection({
    super.key,
    required this.historyKey,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HistoryProvider>();

    return Container(
      key: historyKey,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderTopic(topic: "History Result"),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: provider.history.length,
            itemBuilder: (context, index) {
              final item = provider.history[index];

              return Card(
                child: ListTile(
                  leading:
                  const Icon(Icons.favorite, color: Colors.red),
                  title: Text("HR: ${item.heartRate} bpm"),
                  subtitle:
                  Text("Resp: ${item.respirationRate}"),
                  trailing: Text(item.posture.name),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}