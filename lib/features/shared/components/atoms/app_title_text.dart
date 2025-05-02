import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedlist/core/constants/app_colors.dart';
import 'package:wedlist/core/constants/app_sizes.dart';

class AppTitleText extends StatelessWidget {
  final String text;

  const AppTitleText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
            onTap: () {}, child: Image.asset('assets/icons/info.png')),
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: AppSizes.fontHuge,
            fontWeight: AppSizes.weightExtraBold,
            color: AppColors.textBlack,
          ),
        ),
      ],
    );
  }
}
