import 'package:flutter/material.dart';
import 'package:wedlist/core/constants/app_colors.dart';
import 'package:wedlist/core/constants/app_sizes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: AppColors.borderGrey,
            thickness: 1.0,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: AppSizes.paddingSm),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingSm,
            vertical: 2,
          ),
          child: Text(
            t.or,
            style: TextStyle(
              color: AppColors.hintGrey,
              fontWeight: AppSizes.weightMedium,
              fontSize: AppSizes.fontMd,
            ),
          ),
        ),
        const Expanded(
          child: Divider(
            color: AppColors.borderGrey,
            thickness: 1.0,
          ),
        ),
      ],
    );
  }
}
