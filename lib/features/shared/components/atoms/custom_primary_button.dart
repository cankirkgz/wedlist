import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedlist/core/constants/app_colors.dart';
import 'package:wedlist/core/constants/app_sizes.dart';

class CustomPrimaryButton extends StatelessWidget {
  final String? text;
  final VoidCallback onTap;
  final Color color;
  final Color textColor;
  final Widget? widget;
  final bool hasShadow;
  final bool hasBorder;
  final bool isLoading;
  final Color? borderColor;

  const CustomPrimaryButton({
    super.key,
    this.text,
    required this.onTap,
    this.color = AppColors.primary,
    this.textColor = AppColors.white,
    this.widget,
    this.hasShadow = true,
    this.hasBorder = false,
    this.isLoading = false,
    this.borderColor,
  }) : assert(
          text != null || widget != null,
          'Either text or widget must be provided.',
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.heightXl,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: hasShadow
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(0, 4),
                  blurRadius: 10,
                ),
              ]
            : null,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusLg),
            side: hasBorder
                ? BorderSide(
                    color: borderColor ?? AppColors.borderGrey,
                    width: AppSizes.borderWidthLg,
                  )
                : BorderSide.none,
          ),
        ),
        child: isLoading
            ? const CircularProgressIndicator(
                color: AppColors.primary,
                strokeWidth: 2.5,
              )
            : widget ??
                Text(
                  text!,
                  style: GoogleFonts.inter(
                    fontWeight: AppSizes.weightBold,
                    fontSize: AppSizes.fontXl,
                  ),
                ),
      ),
    );
  }
}
