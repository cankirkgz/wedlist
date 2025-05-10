import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedlist/core/constants/app_colors.dart';
import 'package:wedlist/core/constants/app_sizes.dart';

class RoomCodeText extends StatelessWidget {
  final String code;

  const RoomCodeText({
    super.key,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.heightXxl * 1.2,
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.paddingXl,
        vertical: AppSizes.paddingMd,
      ),
      decoration: BoxDecoration(
        color: AppColors.softPrimary,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        boxShadow: [], // Gölge sıfırlandı
      ),
      child: Center(
        child: Text(
          code,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: AppSizes.fontXxl,
            fontWeight: AppSizes.weightExtraBold,
            color: AppColors.primary,
            letterSpacing: AppSizes.letterSpacingXl,
          ),
        ),
      ),
    );
  }
}
