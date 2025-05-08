import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return Container(
      height: AppSizes.heightHuge,
      padding: const EdgeInsets.all(16),
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
              const SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: AppSizes.fontXl,
                  color: AppColors.boldGreyText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '₺${amount.toStringAsFixed(0)}',
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          if (footer != null) ...[
            const SizedBox(height: 12),
            footer!,
          ]
        ],
      ),
    );
  }
}
