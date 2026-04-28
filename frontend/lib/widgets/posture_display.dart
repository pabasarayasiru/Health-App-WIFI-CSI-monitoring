import 'package:flutter/material.dart';
import 'package:frontend/widgets/sub_header_topic.dart';

import '../features/models/models.dart';

class PostureWidget extends StatelessWidget {
  final Posture posture;

  const PostureWidget({super.key, required this.posture});

  String getImage() {
    switch (posture) {
      case Posture.prone:
        return "assets/images/prone.png";
      case Posture.left:
        return "assets/images/left.png";
      case Posture.right:
        return "assets/images/right.png";
      case Posture.supine:
        return "assets/images/supine.png";
      default:
        return "assets/images/unknown.png";
    }
  }

  @override
  Widget build(BuildContext context) {
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

                SubHeaderTopic(topic: "Posture"),

                const SizedBox(height: 20),

                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        getImage(),
                        height: 200,
                        width: double.infinity,
                      ),

                      const SizedBox(height: 10),

                      Text(
                        posture.name.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20,)
      ],
    );
  }
}