import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:wedlist/core/constants/app_colors.dart';

class StarRating extends StatelessWidget {
  final double rating; // 0.0 ile 5.0 arası değer

  const StarRating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rating,
      itemBuilder: (context, index) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      itemCount: 5,
      itemSize: 20.0,
      unratedColor: AppColors.lightGrey,
      direction: Axis.horizontal,
    );
  }
}
