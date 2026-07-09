import 'package:flutter/material.dart';
import 'package:frontend/widgets/sub_header_topic.dart';

class HeartRateWidget extends StatefulWidget {
  final double? heartRate;

  const HeartRateWidget({super.key, this.heartRate});

  @override
  State<HeartRateWidget> createState() => _HeartRateWidgetState();
}

class _HeartRateWidgetState extends State<HeartRateWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(covariant HeartRateWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // adjust speed based on heart rate
    final bpmValue = widget.heartRate ?? 60.0;

    final durationMs = (60000 / bpmValue).clamp(300, 1200).toInt();

    _controller.duration = Duration(milliseconds: durationMs);
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bpm = widget.heartRate;

    return Column(
      children: [
        Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),

              gradient: LinearGradient(
                colors: [
                  Colors.deepPurple.shade100,
                  Colors.white60,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),

              boxShadow: [
                BoxShadow(
                  color: Colors.deepPurple.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SubHeaderTopic(topic: " Heart Rate"),


                Center(
                  child: Column(
                    children: [

                      ScaleTransition(
                        scale: _scaleAnimation,
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 100,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Center(
                        child: bpm != null 
                          ? Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: bpm.toStringAsFixed(2),
                                    style: const TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "  bpm",
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurple.shade800,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const Text(
                              "--",
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20,),
              ],
            ),
          ),
        ),
        SizedBox(height: 20,),
      ]
    );
  }
}