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

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onTap,
    this.color = AppColors.primary,
    this.textColor = AppColors.white,
    this.widget,
    this.hasShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.heightXl,
      width: double.infinity,
      decoration: hasShadow
          ? BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(0, 4),
                  blurRadius: 10,
                ),
              ],
              borderRadius: BorderRadius.circular(AppSizes.radiusLg),
            )
          : null,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          elevation: 0, // shadow varsa Container kullanıyor
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusLg),
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
