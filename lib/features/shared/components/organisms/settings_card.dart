import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedlist/core/constants/app_colors.dart';
import 'package:wedlist/core/constants/app_sizes.dart';

class SettingsCard extends StatelessWidget {
  final Widget child;
  final String title;

  const SettingsCard({super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.roboto(
                fontSize: AppSizes.fontLg,
                color: AppColors.boldGreyText,
                fontWeight: AppSizes.weightBold,
              ),
            ),
            SizedBox(height: AppSizes.paddingMd),
            child,
          ],
        ),
      ),
    );
  }
}
