import 'package:flutter/material.dart';
import 'package:wedlist/core/constants/app_colors.dart';
import 'package:wedlist/core/constants/app_sizes.dart';

class CustomGradientProgressBar extends StatelessWidget {
  final double percentage; // 0.0 - 1.0 arasında olmalı

  const CustomGradientProgressBar({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.heightXs,
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(AppSizes.radiusCircle),
      ),
      child: Stack(
        children: [
          // Arka plan (renkli ilerleme)
          FractionallySizedBox(
            widthFactor: percentage.clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.softPrimaryText,
                    AppColors.primary,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(AppSizes.radiusCircle),
              ),
              alignment: Alignment.center, // yazıyı ortala
              child: Text(
                '${(percentage * 100).toInt()}%',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
