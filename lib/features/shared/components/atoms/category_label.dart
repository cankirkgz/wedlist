import 'package:flutter/material.dart';
import 'package:wedlist/core/constants/app_colors.dart';
import 'package:wedlist/core/constants/app_sizes.dart';

class CategoryLabel extends StatelessWidget {
  final String text;

  const CategoryLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.paddingSm,
        horizontal: AppSizes.paddingMd,
      ),
      decoration: BoxDecoration(
        color: AppColors.buttonSoftPrimary,
        borderRadius: BorderRadius.circular(AppSizes.radiusCircle),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.primaryText,
          fontWeight: AppSizes.weightMedium,
        ),
      ),
    );
  }
}
