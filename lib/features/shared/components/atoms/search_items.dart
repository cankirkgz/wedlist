import 'package:flutter/material.dart';
import 'package:wedlist/core/constants/app_colors.dart';
import 'package:wedlist/core/constants/app_sizes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      height: AppSizes.heightLg,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/icons/search.png',
            width: 20,
            height: 20,
            color: AppColors.hintGrey,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              decoration: InputDecoration(
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
