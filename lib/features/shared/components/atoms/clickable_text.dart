import 'package:flutter/material.dart';
import 'package:wedlist/core/constants/app_colors.dart';
import 'package:wedlist/core/constants/app_sizes.dart';

class ClickableText extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onTap;

  const ClickableText({
    super.key,
    required this.text,
    this.color = AppColors.primary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: AppSizes.fontLg,
        ),
      ),
    );
  }
}
