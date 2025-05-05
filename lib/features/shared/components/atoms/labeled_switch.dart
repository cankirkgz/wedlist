import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedlist/core/constants/app_colors.dart';
import 'package:wedlist/core/constants/app_sizes.dart';

class LabeledSwitch extends StatelessWidget {
  final String label;
  final ValueNotifier<bool> controller;

  const LabeledSwitch({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder<bool>(
          valueListenable: controller,
          builder: (context, value, _) {
            return AdvancedSwitch(
              controller: controller,
              activeColor: AppColors.primary,
              inactiveColor: AppColors.borderGrey,
              thumb: const Icon(Icons.circle, color: AppColors.white, size: 20),
            );
          },
        ),
        const SizedBox(width: AppSizes.paddingMd),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: AppSizes.fontMd,
            fontWeight: FontWeight.w500,
            color: AppColors.textBlack,
          ),
        ),
      ],
    );
  }
}
