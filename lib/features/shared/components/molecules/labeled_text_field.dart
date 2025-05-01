import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedlist/core/constants/app_sizes.dart';
import 'package:wedlist/core/constants/app_colors.dart';
import 'package:wedlist/features/shared/components/atoms/custom_text_field.dart';

class LabeledTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final IconData? prefixIcon;
  final IconData? suffixIcon;

  const LabeledTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.roboto(
            fontSize: AppSizes.fontLg,
            fontWeight: FontWeight.w500,
            color: AppColors.textBlack,
          ),
        ),
        const SizedBox(height: AppSizes.paddingSm),
        CustomTextField(
          hintText: hintText,
          controller: controller,
          isPassword: isPassword,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
      ],
    );
  }
}
