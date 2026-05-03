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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SubHeaderTopic(topic: "Posture Distribution"),
          SizedBox(height: 10,),
          SizedBox(
            height: 220,
            child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Center(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 🥧 PIE CHART
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SizedBox(
                        width: 220,
                        height: 220,
                        child: PieChart(
                          PieChartData(
                            centerSpaceRadius: 20,
                            sectionsSpace: 2,
                            sections: [
                              PieChartSectionData(
                                value: stats.supine,
                                radius: 90,
                                color: Colors.blue,
                                title: "",
                              ),
                              PieChartSectionData(
                                value: stats.prone,
                                radius: 90,
                                color: Colors.deepPurple,
                                title: "",
                              ),
                              PieChartSectionData(
                                value: stats.left,
                                radius: 90,
                                color: Colors.green,
                                title: "",
                              ),
                              PieChartSectionData(
                                value: stats.right,
                                radius: 90,
                                color: Colors.orange,
                                title: "",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 20),

                    // 📊 LEGEND (OUTSIDE LABELS)
                    SizedBox(
                      width: 200,
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
                            color: Colors.deepPurple,
                            text:
                            "Prone - ${percent(stats.prone).toStringAsFixed(2)}%",
                          ),
                          const SizedBox(height: 10),
                          LegendItem(
                            color: Colors.green,
                            text:
                            "Left - ${percent(stats.left).toStringAsFixed(2)}%",
                          ),
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
              ),
            ),
          ),
          const SizedBox(height: 20),
      ],
    );
  }
}