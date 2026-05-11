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
  final GlobalKey liveHeartRateKey = GlobalKey();
  final GlobalKey respirationRateKey = GlobalKey();
  final GlobalKey postureKey = GlobalKey();

  final GlobalKey historyKey = GlobalKey();
  final GlobalKey calendarKey = GlobalKey();
  final GlobalKey summeryKey = GlobalKey();
  final GlobalKey hourlyBarChartKey = GlobalKey();
  final GlobalKey posturePieChartKey = GlobalKey();

  final GlobalKey sleepSectionKey = GlobalKey();

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
      historyProvider.loadByDate();
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

      body: SafeArea(
          child: Column(
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
                        onCalendarTap: () => scrollTo(calendarKey),
                        onSummeryTap: () => scrollTo(summeryKey),
                        onHourlyBarChartTap: () => scrollTo(hourlyBarChartKey),
                        onPosturePieChartTap: () => scrollTo(posturePieChartKey),
                        onSleepMonitoringTap: () => scrollTo(sleepSectionKey),
                      ),

                      //  Main Content
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            final realTimeProvider = context.read<RealtimeProvider>();
                            final historyProvider = context.read<HistoryProvider>();

                            // restart websocket
                            realTimeProvider.stop();
                            realTimeProvider.start();

                            // reload data
                            await historyProvider.loadByDate();
                          },

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
                                HistorySection(
                                  historyKey: historyKey,
                                  summeryKey: summeryKey,
                                  hourlyBarChartKey: hourlyBarChartKey,
                                  posturePieChartKey: posturePieChartKey,
                                  calendarKey: calendarKey,
                                ),

                                const Divider(),

                                // SLEEP MONITORING
                                SleepMonitoring(
                                  sleepSectionKey: sleepSectionKey,
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),



                const AppFooter(),
              ]

          ),
      ),

    );
  }
}
