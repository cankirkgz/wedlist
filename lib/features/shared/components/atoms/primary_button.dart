import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedlist/core/constants/app_colors.dart';
import 'package:wedlist/core/constants/app_sizes.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;
  final Color textColor;
  final Widget? widget;
  final bool hasShadow;
  final bool hasBorder; // yeni eklendi

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onTap,
    this.color = AppColors.primary,
    this.textColor = AppColors.white,
    this.widget,
    this.hasShadow = true,
    this.hasBorder = false, // varsayılan olarak border yok
  });

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
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusLg),
            side: hasBorder
                ? const BorderSide(
                    color: AppColors.borderGrey,
                    width: AppSizes.borderWidthLg,
                  )
                : BorderSide.none,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingLg,
            vertical: AppSizes.paddingSm,
          ),
        ),
        child: widget ??
            Text(
              text,
              style: GoogleFonts.roboto(
                fontWeight: AppSizes.weightBold,
                fontSize: AppSizes.fontXl,
              ),
            ),
      ),
    );
  }
}
