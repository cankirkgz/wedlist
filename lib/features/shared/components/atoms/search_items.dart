import 'package:flutter/material.dart';
import 'package:wedlist/core/constants/app_colors.dart';
import 'package:wedlist/core/constants/app_sizes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchItems extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const SearchItems({
    super.key,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Container(
      height: 40.h, // Daha kompakt hale getirdik
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius:
            BorderRadius.circular(AppSizes.radiusSm), // Daha küçük radius
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/icons/search.png',
            width: 18.w,
            height: 18.w,
            color: AppColors.hintGrey,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: TextStyle(fontSize: AppSizes.fontSm),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                hintText: t.searchItems,
                hintStyle: TextStyle(color: AppColors.hintGrey),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
