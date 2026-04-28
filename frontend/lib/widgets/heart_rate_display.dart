import 'package:flutter/material.dart';
import 'package:frontend/widgets/sub_header_topic.dart';

class HeartRateWidget extends StatefulWidget {
  final int? heartRate;

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
    final bpm = widget.heartRate ?? 60;

    final durationMs = (60000 / bpm).clamp(300, 1200).toInt();

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

                      Text(
                        bpm != null ? "$bpm bpm" : "--",
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
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