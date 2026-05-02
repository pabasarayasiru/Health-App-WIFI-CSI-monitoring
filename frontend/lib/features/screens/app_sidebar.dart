import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';

class AppSidebar extends StatelessWidget {
  final bool isOpen;

  final VoidCallback onLiveTap;
  final VoidCallback onLiveHeartTap;
  final VoidCallback onLiveRespirationTap;
  final VoidCallback onLivePostureTap;
  final VoidCallback onHistoryTap;
  final VoidCallback onSummeryTap;
  final VoidCallback onHourlyBarChartTap;
  final VoidCallback onPosturePieChartTap;
  final VoidCallback onCalendarTap;

  const AppSidebar({
    super.key,
    required this.isOpen,
    required this.onLiveTap,
    required this.onLiveHeartTap,
    required this.onLiveRespirationTap,
    required this.onLivePostureTap,
    required this.onHistoryTap,
    required this.onSummeryTap,
    required this.onHourlyBarChartTap,
    required this.onPosturePieChartTap,
    required this.onCalendarTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isOpen ? 180 : 70,
      height: double.infinity,
      color: isOpen ? Colors.deepPurpleAccent : Colors.deepPurpleAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Live
          SidebarTile(
            title: "Live",
            icon: Icons.live_tv,
            isSidebarOpen: isOpen,
            onTap: onLiveTap,
          ),

          if(isOpen)
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                children: [
                  SidebarTile(
                    title: "Heart Rate",
                    icon: Icons.monitor_heart_rounded,
                    isSidebarOpen: isOpen,
                    onTap: onLiveHeartTap,
                  ),
                  SidebarTile(
                    title: "Respiration Rate",
                    icon: Icons.candlestick_chart,
                    isSidebarOpen: isOpen,
                    onTap: onLiveRespirationTap,
                  ),
                  SidebarTile(
                    title: "Posture",
                    icon: Icons.bed_rounded,
                    isSidebarOpen: isOpen,
                    onTap: onLivePostureTap,
                  ),
                ],
              ),
            ),




          // history
          SidebarTile(
            title: "History",
            icon: Icons.history,
            isSidebarOpen: isOpen,
            onTap: onHistoryTap,
          ),
          if(isOpen)
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                children:[
                  SidebarTile(
                    title: "Select Date",
                    icon: Icons.calendar_month,
                    isSidebarOpen: isOpen,
                    onTap: onCalendarTap,
                  ),
                  SidebarTile(
                    title: "Daily Summery",
                    icon: Icons.hourglass_bottom,
                    isSidebarOpen: isOpen,
                    onTap: onSummeryTap,
                  ),
                  SidebarTile(
                    title: "Hourly Summery",
                    icon: Icons.bar_chart,
                    isSidebarOpen: isOpen,
                    onTap: onHourlyBarChartTap,
                  ),
                  SidebarTile(
                    title: "Posture Summery",
                    icon: Icons.pie_chart,
                    isSidebarOpen: isOpen,
                    onTap: onPosturePieChartTap,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
