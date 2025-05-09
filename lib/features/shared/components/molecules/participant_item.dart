import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedlist/core/constants/app_colors.dart';
import 'package:wedlist/core/constants/app_sizes.dart';

class ParticipantItem extends StatelessWidget {
  final String initials;
  final String name;
  final String role;
  final bool isOnline;

  const ParticipantItem({
    super.key,
    required this.initials,
    required this.name,
    required this.role,
    required this.isOnline,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: AppColors.softPrimary,
        child: Text(
          initials,
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ),
      title: Text(
        name,
        style: GoogleFonts.roboto(
          fontSize: AppSizes.fontLg,
          fontWeight: AppSizes.weightMedium,
        ),
      ),
    );
  }
}
