import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wedlist/core/constants/app_colors.dart';
import 'package:wedlist/core/constants/app_sizes.dart';

class FinancialStatusCard extends StatelessWidget {
  final String iconAssetPath;
  final String title;
  final double amount;
  final Color backgroundColor;
  final Widget? footer;

  const FinancialStatusCard({
    super.key,
    required this.iconAssetPath,
    required this.title,
    required this.amount,
    required this.backgroundColor,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    String getCurrencySymbol(BuildContext context) {
      final locale = Localizations.localeOf(context).languageCode;

      switch (locale) {
        case 'tr':
          return '₺';
        case 'ru':
          return '₽';
        case 'de':
          return '€';
        case 'en':
        default:
          return '\$';
      }
    }

    return Container(
      height: AppSizes.heightHuge,
      padding: EdgeInsets.all(AppSizes.paddingMd),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppSizes.radiusXl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                iconAssetPath,
                width: AppSizes.heightXxs,
                height: AppSizes.heightXxs,
                fit: BoxFit.contain,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: AppSizes.fontXl,
                    color: AppColors.boldGreyText,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              '${getCurrencySymbol(context)}${amount.toStringAsFixed(0)}',
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (footer != null) ...[
            SizedBox(height: 12.h),
            footer!,
          ]
        ],
      ),
    );
  }
}
