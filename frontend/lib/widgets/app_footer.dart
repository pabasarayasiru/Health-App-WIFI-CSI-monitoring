import 'package:flutter/material.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      color: Colors.black87,

      child: const Text(
        "© 2026 Health Monitoring System",
        style: TextStyle(
          color: Colors.white70,
          fontSize: 12,
        ),
      ),
    );
  }
}