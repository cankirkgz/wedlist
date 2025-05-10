import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedlist/core/constants/app_sizes.dart';
import 'package:wedlist/core/constants/app_colors.dart';
import 'package:wedlist/features/shared/components/atoms/custom_dropdown_field.dart';

class LabeledDropdownField extends StatelessWidget {
  final String label;
  final String? selectedValue;
  final List<String> items;
  final ValueChanged<String> onChanged;

  const LabeledDropdownField({
    super.key,
    required this.label,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: AppSizes.fontLg,
            fontWeight: FontWeight.w500,
            color: AppColors.textBlack,
          ),
        ),
        SizedBox(height: AppSizes.paddingSm),
        CustomDropdownField(
          selectedValue: selectedValue,
          items: items,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
