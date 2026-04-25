import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';

class AppSidebar extends StatelessWidget {
  final bool isOpen;
  final VoidCallback onToggle;

  final VoidCallback onLiveTap;
  final VoidCallback onLiveHeartTap;
  final VoidCallback onHistoryTap;

  const AppSidebar({
    super.key,
    required this.isOpen,
    required this.onToggle,
    required this.onLiveTap,
    required this.onLiveHeartTap,
    required this.onHistoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isOpen ? 200 : 60,
      color: Colors.black87,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: onToggle,
          ),


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
              child: SidebarTile(
                title: "Heart Rate",
                icon: Icons.monitor_heart_rounded,
                isSidebarOpen: isOpen,
                onTap: onLiveHeartTap,
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
              child: SidebarTile(
                title: "Heart Rate",
                icon: Icons.monitor_heart_rounded,
                isSidebarOpen: isOpen,
                onTap: onLiveHeartTap,
              ),
            ),
        ],
      ),
    );
  }
}