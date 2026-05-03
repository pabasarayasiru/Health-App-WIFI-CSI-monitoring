import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:frontend/features/features.dart';
import 'package:frontend/widgets/widgets.dart';


class HourlyBarChart extends StatelessWidget {
  final List<HourlyData> data;

  const HourlyBarChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(child: Text("No data for selected date"));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        SubHeaderTopic(topic: "Hourly Summery"),
        SizedBox(height: 10,),
        // 📊 CHART
        SizedBox(
          height: 350,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: data.length * 60,
              child: BarChart(
                BarChartData(
                  maxY: _getMaxY(),

                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),

                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        interval: 10,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),

                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index >= data.length) {
                            return const Text("");
                          }

                          return Text(
                            "${data[index].hour}:00",
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),
                  ),

                  gridData: const FlGridData(show: true),

                  barGroups: data.asMap().entries.map((e) {
                    final item = e.value;

                    return BarChartGroupData(
                      x: e.key,
                      barsSpace: 4,
                      barRods: [
                        // 🟦 HEART RATE
                        BarChartRodData(
                          toY: item.avgHeartRate,
                          width: 20,
                          color: Colors.deepPurple.shade800,
                        ),

                        // 🟧 RESPIRATION RATE
                        BarChartRodData(
                          toY: item.avgRespirationRate,
                          width: 20,
                          color: Colors.blueAccent,
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        // 🧠 LEGEND (IMPORTANT ADDITION)
        Row(
          children: const [
            LegendItem(color: Colors.deepPurple, text: "Heart Rate"),
            SizedBox(width: 20),
            LegendItem(color: Colors.blueAccent, text: "Respiration Rate"),
          ],
        ),
        const SizedBox(height: 100),
      ],
    );
  }

  double _getMaxY() {
    double maxVal = 0;

    for (var d in data) {
      if (d.avgHeartRate > maxVal) maxVal = d.avgHeartRate;
      if (d.avgRespirationRate > maxVal) maxVal = d.avgRespirationRate;
    }

    return maxVal + 10;
  }
}