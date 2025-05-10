import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedlist/core/constants/app_colors.dart';
import 'package:wedlist/core/constants/app_sizes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PriorityRatingBar extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;

  const PriorityRatingBar({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.priorityLevel,
          style: GoogleFonts.inter(
            fontSize: AppSizes.fontLg,
            fontWeight: FontWeight.w500,
            color: AppColors.textBlack,
          ),
        ),
        SizedBox(height: AppSizes.paddingXs),
        RatingBar.builder(
          initialRating: value.toDouble(),
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: false,
          itemCount: 5,
          itemSize: AppSizes.heightXs,
          unratedColor: AppColors.borderGrey,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: AppColors.primary,
          ),
          onRatingUpdate: (rating) {
            onChanged(rating.toInt());
          },
        ),
        SizedBox(height: AppSizes.paddingXs),
        Text(
          t.priorityQuestion,
          style: GoogleFonts.inter(
            fontSize: AppSizes.fontMd,
            fontWeight: FontWeight.w500,
            color: AppColors.greyText,
          ),
        ),
      ],
    );
  }
}
