import 'dart:math';
import 'package:flutter/material.dart';
import 'package:frontend/widgets/sub_header_topic.dart';

class RespirationWidget extends StatefulWidget {
  final int? respirationRate;

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

    final rate = widget.respirationRate ?? 16;

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
          child: Padding(
            padding: const EdgeInsets.all(20),
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
                  child: Text(
                    rate != null ? "$rate bpm" : "--",
                    style: const TextStyle(
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
      ..color = Colors.blue
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