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
  final GlobalKey respirationRateKey = GlobalKey();
  final GlobalKey postureKey = GlobalKey();

  bool isSidebarOpen = false;

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
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

      body: Column(
        children: [

          Material(
            elevation: 4,
            child: AppHeader(
              onToggle: () {
                setState(() {
                  isSidebarOpen = !isSidebarOpen;
                });
              },
            ),
          ),

          Expanded(
              child: Row(
                children: [
                  // sidebar
                  AppSidebar(
                    isOpen: isSidebarOpen,
                    onLiveTap: () => scrollTo(liveKey),
                    onLiveHeartTap: () => scrollTo(liveHeartRateKey),
                    onHistoryTap: () => scrollTo(historyKey),
                    onLiveRespirationTap: () => scrollTo(respirationRateKey),
                    onLivePostureTap: () => scrollTo(postureKey),
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
                            respirationRateKey: respirationRateKey,
                            postureKey: postureKey,
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
          ),



          const AppFooter(),
        ]

      )

    );
  }
}
