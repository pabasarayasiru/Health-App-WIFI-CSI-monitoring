import 'dart:math';
import 'package:flutter/material.dart';
import 'package:frontend/widgets/sub_header_topic.dart';

class RespirationWidget extends StatefulWidget {
  final double? respirationRate;

  const RespirationWidget({super.key, this.respirationRate});

  @override
  State<RespirationWidget> createState() => _RespirationWidgetState();
}

class _RespirationWidgetState extends State<RespirationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void didUpdateWidget(covariant RespirationWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    final rate = widget.respirationRate ?? 16.0;

    // Use toInt() here for the duration calculation
    final durationMs = (60000 / rate).clamp(800, 4000).toInt();

    _controller.duration = Duration(milliseconds: durationMs);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rate = widget.respirationRate;

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
                SubHeaderTopic(topic: "Respiration"),

                const SizedBox(height: 20),

                SizedBox(
                  height: 80,
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (_, __) {
                      return CustomPaint(
                        painter: _WavePainter(_controller.value),
                        size: Size.infinite,
                      );
                    },
                  ),
                ),

                const SizedBox(height: 10),

                Center(
                  child: rate != null 
                    ? Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: rate.toStringAsFixed(2),
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
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20,),
      ],
    );
  }
}

class _WavePainter extends CustomPainter {
  final double value;

  _WavePainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.deepPurple.shade800
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();

    for (double x = 0; x < size.width; x++) {
      double y = size.height / 2 +
          sin((x / size.width * 2 * pi) + (value * 2 * pi)) * 20;

      if (x == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}