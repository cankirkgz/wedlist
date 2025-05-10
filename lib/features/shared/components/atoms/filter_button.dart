import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wedlist/core/constants/app_colors.dart';
import 'package:wedlist/core/constants/app_sizes.dart';
import 'package:wedlist/features/checklist/view/filter_checklist_sheet.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          builder: (_) => const FilterChecklistSheet(),
        );
      },
      child: Container(
        height: 40.h, // Aynı yükseklik
        width: 40.h, // Kare
        decoration: BoxDecoration(
          color: AppColors.lightGrey,
          borderRadius: BorderRadius.circular(AppSizes.radiusSm),
        ),
        child: Center(
          child: Image.asset(
            'assets/icons/filter.png',
            width: 18.w,
            height: 18.w,
          ),
        ),
      ),
    );
  }
}
