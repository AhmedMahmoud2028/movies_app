import 'package:flutter/material.dart';

class ScreenshotCard extends StatelessWidget {
  final String screenShot;
  const ScreenshotCard({super.key, required this.screenShot});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 165,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
              image: NetworkImage(screenShot),
              fit: BoxFit.cover)
      ),
    );
  }
}
