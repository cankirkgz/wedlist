import 'package:flutter/material.dart';
import 'package:wedlist/core/constants/app_colors.dart';
import 'package:wedlist/core/constants/app_sizes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomDropdownField extends StatelessWidget {
  final String? selectedValue;
  final List<String> items;
  final ValueChanged<String> onChanged;

  const CustomDropdownField({
    super.key,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: () => _showBottomSheet(context),
      child: Container(
        height: AppSizes.heightXl,
        padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingMd),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSizes.radiusLg),
          border: Border.all(
            color: AppColors.borderGrey,
            width: AppSizes.borderWidthLg,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                selectedValue ?? t.selectAnOption,
                style: TextStyle(
                  fontSize: AppSizes.fontMd,
                  color: AppColors.textBlack,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(Icons.keyboard_arrow_down_rounded,
                color: AppColors.textBlack),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => ListView(
        padding: EdgeInsets.all(AppSizes.paddingMd),
        children: items.map((item) {
          return ListTile(
            title: Text(item),
            onTap: () {
              Navigator.pop(context);
              onChanged(item);
            },
          );
        }).toList(),
      ),
    );
  }
}
