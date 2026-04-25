import 'package:flutter/material.dart';

class SubHeaderTopic extends StatelessWidget {
  const SubHeaderTopic({
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
                  fontSize: 22, fontWeight: FontWeight.bold
              )
          ),
          SizedBox(height: 10),
        ]
    );
  }
}