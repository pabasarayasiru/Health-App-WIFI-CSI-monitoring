import 'package:flutter/material.dart';
import 'package:frontend/widgets/widgets.dart';

class SummeryCard extends StatelessWidget {
  final double? avgHeart;
  final double? avgResp;

  const SummeryCard({
    super.key,
    required this.avgHeart,
    required this.avgResp,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: StatsCard(
                title: "Avg HR",
                value: avgHeart != null
                    ? avgHeart!.toStringAsFixed(1)
                    : "-",
              ),
            ),
            Expanded(
              child: StatsCard(
                title: "Avg Resp",
                value: avgResp != null
                    ? avgResp!.toStringAsFixed(1)
                    : "-",
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}