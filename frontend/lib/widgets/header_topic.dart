import 'package:flutter/material.dart';

class HeaderTopic extends StatelessWidget {
  const HeaderTopic({
    required this.topic,
    super.key
  });

  final String topic;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(topic,
            style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold,
              color: Colors.deepPurple.shade900,
            )
        ),
        SizedBox(height: 10),
      ]
    );
  }
}
