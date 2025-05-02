import 'package:flutter/material.dart';

class AppSquareImage extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;
  final Color backgroundColor;
  final double borderRadius;

  const AppSquareImage({
    super.key,
    required this.imagePath,
    this.width = double.infinity,
    this.height = double.infinity,
    this.backgroundColor = const Color(0xFFFDEEEE),
    this.borderRadius = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 0.5),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
