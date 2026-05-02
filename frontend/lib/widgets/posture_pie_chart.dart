import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:frontend/features/features.dart';
import 'widgets.dart';

class PosturePieChart extends StatelessWidget {
  final PostureStats stats;

  const PosturePieChart({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final total =
        stats.supine + stats.prone + stats.left + stats.right;

    if (total <= 0) {
      return const Center(child: Text("No posture data"));
    }

    double percent(double value) => (value / total) * 100;

    return SizedBox(
      height: 400,
      child: Column(
        children: [
          const Text(
            "Posture Distribution",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              // 🥧 PIE CHART
              Expanded(
                flex: 2,
                child: PieChart(
                  PieChartData(
                    centerSpaceRadius: 20,
                    sectionsSpace: 2,
                    sections: [
                      PieChartSectionData(
                        value: stats.supine,
                        radius: 100,
                        color: Colors.blue,
                        title: "",
                      ),
                      PieChartSectionData(
                        value: stats.prone,
                        radius: 100,
                        color: Colors.red,
                        title: "",
                      ),
                      PieChartSectionData(
                        value: stats.left,
                        radius: 100,
                        color: Colors.green,
                        title: "",
                      ),
                      PieChartSectionData(
                        value: stats.right,
                        radius: 100,
                        color: Colors.orange,
                        title: "",
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 20),

              // 📊 LEGEND (OUTSIDE LABELS)
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LegendItem(
                      color: Colors.blue,
                      text:
                      "Supine - ${percent(stats.supine).toStringAsFixed(2)}%",
                    ),
                    const SizedBox(height: 10),
                    LegendItem(
                      color: Colors.red,
                      text:
                      "Prone - ${percent(stats.prone).toStringAsFixed(2)}%",
                    ),
                    const SizedBox(height: 10),
                    LegendItem(
                      color: Colors.green,
                      text:
                      "Left - ${percent(stats.left).toStringAsFixed(2)}%",
                    ),
                    const SizedBox(height: 10),
                    LegendItem(
                      color: Colors.orange,
                      text:
                      "Right - ${percent(stats.right).toStringAsFixed(2)}%",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}