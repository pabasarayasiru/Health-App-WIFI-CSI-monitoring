import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  final VoidCallback onToggle;

  const AppHeader({
    super.key,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      color: Colors.black87,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: onToggle,
          ),

          const SizedBox(width: 40,),
          const Text(
            "Health Monitoring",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}