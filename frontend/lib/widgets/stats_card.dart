import 'package:flutter/material.dart';

class StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color; // 👈 add color input

  const StatsCard({
    super.key,
    required this.title,
    required this.value,
    this.color = Colors.deepPurple, // default color
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6, // 👈 shadow depth
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      shadowColor: color.withOpacity(0.4),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),

          // 🎨 GRADIENT BACKGROUND
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.85),
              color.withOpacity(0.55),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white, // 👈 contrast
              ),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}