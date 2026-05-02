import 'package:flutter/material.dart';
import 'package:frontend/features/features.dart';
import 'package:provider/provider.dart';
import 'package:frontend/widgets/widgets.dart';

class HistorySection extends StatelessWidget {

  final GlobalKey historyKey;
  final GlobalKey summeryKey;
  final GlobalKey hourlyBarChartKey;
  final GlobalKey posturePieChartKey;
  final GlobalKey calendarKey;

  const HistorySection({
    super.key,
    required this.historyKey,
    required this.summeryKey,
    required this.hourlyBarChartKey,
    required this.posturePieChartKey,
    required this.calendarKey,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HistoryProvider>();

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Container(
        key: historyKey,
        padding: const EdgeInsets.all(16),
        child :Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderTopic(topic: "History Analytics"),


            Container(
              key: calendarKey,
              child: const DateSelector(),
            ),



            Container(
              key: summeryKey,
              child: SummeryCard(
                avgHeart: provider.today?.heart,
                avgResp: provider.today?.resp,
              ),
            ),


            Container(
              key: hourlyBarChartKey,
              child: provider.hourly.isEmpty
                  ? const Center(child: Text("No data for selected date"))
                  : HourlyBarChart(data: provider.hourly),
            ),



            Container(
              key: posturePieChartKey,
              child: provider.posture != null
                  ? PosturePieChart(stats: provider.posture!)
                  : const SizedBox(),
            ),

          ],
        )
    );
  }
}