import 'package:flutter/material.dart';
import 'features/realtime/screens/realtime_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Monitoring App',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),

      // start screen
      home: const RealtimeScreen(),
    );
  }
}
