import 'package:flutter/material.dart';
import 'package:wedlist/core/constants/app_colors.dart';
import 'package:wedlist/core/constants/app_sizes.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: AppColors.borderGrey,
            thickness: 1.0,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: AppSizes.paddingSm),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingSm,
            vertical: 2,
          ),
          child: Text(
            'YA DA',
            style: TextStyle(
              color: AppColors.hintGrey,
              fontWeight: AppSizes.weightMedium,
              fontSize: AppSizes.fontMd,
            ),
          ),
        ),
        const Expanded(
          child: Divider(
            color: AppColors.borderGrey,
            thickness: 1.0,
          ),
        ),
      ],
    );
  }
}
