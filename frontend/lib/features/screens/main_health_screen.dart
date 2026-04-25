import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/features/features.dart';

import '../../widgets/widgets.dart';

class HealthScreen extends StatefulWidget {
  const HealthScreen({super.key});

  @override
  _HealthScreenState createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey liveKey = GlobalKey();
  final GlobalKey historyKey = GlobalKey();
  final GlobalKey liveHeartRateKey = GlobalKey();

  bool isSidebarOpen = true;

  void scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(context,
          duration: Duration(milliseconds: 500));
    }
  }

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final realTimeProvider = context.read<RealtimeProvider>();
      final historyProvider = context.read<HistoryProvider>();

      realTimeProvider.start();
      historyProvider.loadFakeHistory();
    });
  }

  @override
  void dispose() {
    context.read<RealtimeProvider>().stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Row(
        children: [

          // sidebar
          AppSidebar(
            isOpen: isSidebarOpen,
            onToggle: () {
              setState(() {
                isSidebarOpen = !isSidebarOpen;
              });
            },
            onLiveTap: () => scrollTo(liveKey),
            onLiveHeartTap: () => scrollTo(liveHeartRateKey),
            onHistoryTap: () => scrollTo(historyKey),
          ),

          //  Main Content
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // LIVE
                  LiveSection(
                    liveKey: liveKey,
                    heartRateKey: liveHeartRateKey,
                  ),

                  const Divider(),

                  // HISTORY
                  // HistorySection(
                  //   historyKey: historyKey,
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
