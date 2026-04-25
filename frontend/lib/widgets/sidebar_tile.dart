import 'package:flutter/material.dart';

class SidebarTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSidebarOpen;
  final VoidCallback onTap;

  const SidebarTile({
    super.key,
    required this.title,
    required this.icon,
    required this.isSidebarOpen,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: isSidebarOpen
          ? Text(
        title,
        style: const TextStyle(color: Colors.white),
      )
          : null,
      onTap: onTap,
      hoverColor: Colors.white10,
    );
  }
}

