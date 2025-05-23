import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wedlist/core/constants/app_colors.dart';
import 'package:wedlist/core/constants/app_sizes.dart';
import 'package:wedlist/features/checklist/viewmodel/filter_viewmodel.dart';
import 'package:wedlist/features/shared/components/atoms/custom_primary_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wedlist/features/checklist/viewmodel/filter_viewmodel.dart';

class FilterChecklistSheet extends ConsumerWidget {
  const FilterChecklistSheet({super.key});

  List<String> getLocalizedCategories(AppLocalizations t) => [
        t.kitchen,
        t.bathroom,
        t.bedroom,
        t.livingRoom,
        t.studyRoom,
        t.balconyGarden,
        t.electronics,
        t.cleaningProducts,
        t.personalCare,
        t.decoration,
        t.other,
      ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterVM = ref.read(filterProvider.notifier);
    final filter = ref.watch(filterProvider);
    final t = AppLocalizations.of(context)!;
    final categories = getLocalizedCategories(t);

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 32,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Gri bar
            Container(
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 16),

            // Başlık ve kapatma butonu
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  t.filterYourList,
                  style: TextStyle(
                    fontSize: AppSizes.fontXl,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textBlack,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: AppColors.iconGrey),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),

            SizedBox(height: AppSizes.paddingLg),

            // Kategori Başlığı
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                t.category,
                style: TextStyle(
                  fontSize: AppSizes.fontMd,
                  fontWeight: FontWeight.w500,
                  color: AppColors.softTextBlack,
                ),
              ),
            ),
            SizedBox(height: AppSizes.paddingSm),

            // Kategori Seçenekleri
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: categories.map((category) {
                final selected = filter.selectedCategory == category;
                return GestureDetector(
                  onTap: () => filterVM.setCategory(category),
                  child: _buildExpandedChip(
                    category,
                    Icons.label,
                    selected: selected,
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: AppSizes.paddingXl),

            // Öncelik Başlığı
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                t.priority,
                style: TextStyle(
                  fontSize: AppSizes.fontMd,
                  fontWeight: FontWeight.w500,
                  color: AppColors.softTextBlack,
                ),
              ),
            ),
            SizedBox(height: AppSizes.paddingSm),

            // Öncelik Seçenekleri
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: List.generate(5, (index) {
                final star = index + 1;
                final selected = filter.selectedPriority == star;
                return GestureDetector(
                  onTap: () => filterVM.setPriority(star),
                  child: _buildExpandedPriority(star, selected: selected),
                );
              }),
            ),

            SizedBox(height: AppSizes.paddingXl),

            // Satın alma durumu
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                t.purchaseStatus,
                style: TextStyle(
                  fontSize: AppSizes.fontMd,
                  fontWeight: FontWeight.w500,
                  color: AppColors.softTextBlack,
                ),
              ),
            ),
            SizedBox(height: AppSizes.paddingSm),

            // Durum Butonları
            Row(
              children: [
                Expanded(
                  child: _buildStatusButton(
                    t.purchased,
                    selected: filter.status == PurchaseStatus.purchased,
                    onPressed: () {
                      filterVM.setStatus(PurchaseStatus.purchased);
                    },
                  ),
                ),
                SizedBox(width: AppSizes.paddingMd),
                Expanded(
                  child: _buildStatusButton(
                    t.notPurchased,
                    selected: filter.status == PurchaseStatus.notPurchased,
                    onPressed: () {
                      filterVM.setStatus(PurchaseStatus.notPurchased);
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: AppSizes.paddingXl),

            // Butonlar
            CustomPrimaryButton(
              text: t.resetFilter,
              color: AppColors.white,
              textColor: AppColors.boldGreyText,
              hasShadow: false,
              onTap: () => filterVM.reset(),
            ),
            SizedBox(height: AppSizes.paddingMd),
            CustomPrimaryButton(
              text: t.applyFilter,
              hasShadow: false,
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandedChip(String label, IconData icon,
      {bool selected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: selected ? AppColors.primary : AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: selected ? Colors.white : Colors.black54),
          const SizedBox(width: 8),
          Text(label,
              style: TextStyle(
                  color: selected ? Colors.white : AppColors.textBlack,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildExpandedPriority(int stars, {bool selected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: selected ? AppColors.primary : AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(stars,
            (_) => const Icon(Icons.star, size: 16, color: Colors.amber)),
      ),
    );
  }

  Widget _buildStatusButton(String text,
      {required bool selected, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: selected ? AppColors.primary : AppColors.white,
        foregroundColor: selected ? Colors.white : AppColors.boldGreyText,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusLg)),
        elevation: 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
              selected
                  ? 'assets/icons/check_white.png'
                  : 'assets/icons/uncheck.png',
              width: 20,
              height: 20),
          const SizedBox(width: 8),
          Text(text,
              style: TextStyle(
                  color: selected ? Colors.white : AppColors.boldGreyText,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
