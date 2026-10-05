import 'package:flutter/material.dart';


class Poster extends StatelessWidget {
  final String imageUrl;
  final String rating;

  const Poster({
    super.key,
    required this.rating,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          // صورة البوستر
          Positioned.fill(
            child: Image(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          // (Rating Badge)
          Positioned(
            top: 12,
            left: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    rating,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.star, color: Colors.amber, size: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}