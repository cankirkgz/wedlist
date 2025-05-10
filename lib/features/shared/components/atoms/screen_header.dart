import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedlist/core/constants/app_sizes.dart';

class ScreenHeader extends StatelessWidget {
  final String title;
  final String subTitle;

  const ScreenHeader({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: AppSizes.fontXxl,
            fontWeight: AppSizes.weightBold,
          ),
        ),
        SizedBox(height: AppSizes.paddingMd),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.borderWidthMd),
          child: Text(
            subTitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: AppSizes.fontLg,
            ),
          ),
        ),
      ],
    );
  }
}
