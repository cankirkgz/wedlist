import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wedlist/core/constants/app_colors.dart';
import 'package:wedlist/core/constants/app_sizes.dart';
import 'package:wedlist/features/checklist/viewmodel/filter_viewmodel.dart';
import 'package:wedlist/features/shared/components/atoms/custom_primary_button.dart';

class FilterChecklistSheet extends ConsumerWidget {
  const FilterChecklistSheet({super.key});

  final List<String> categories = const [
    "Mutfak",
    "Banyo",
    "Yatak Odası",
    "Salon",
    "Çalışma Odası",
    "Balkon / Bahçe",
    "Elektronik",
    "Temizlik Ürünleri",
    "Kişisel Bakım",
    "Dekorasyon",
    "Diğer",
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterVM = ref.read(filterProvider.notifier);
    final filter = ref.watch(filterProvider);

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(4))),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Listeni Filtrele",
                style: TextStyle(
                    fontSize: AppSizes.fontXl,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textBlack),
              ),
              IconButton(
                  icon: const Icon(Icons.close, color: AppColors.iconGrey),
                  onPressed: () => Navigator.pop(context)),
            ],
          ),
          const SizedBox(height: AppSizes.paddingLg),
          const Align(
              alignment: Alignment.centerLeft,
              child: Text("Kategori",
                  style: TextStyle(
                      fontSize: AppSizes.fontMd,
                      fontWeight: FontWeight.w500,
                      color: AppColors.softTextBlack))),
          const SizedBox(height: AppSizes.paddingSm),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: categories.map((category) {
              final selected = filter.selectedCategory == category;
              return GestureDetector(
                onTap: () => filterVM.setCategory(category),
                child: _buildExpandedChip(category, Icons.label,
                    selected: selected),
              );
            }).toList(),
          ),
          const SizedBox(height: AppSizes.paddingXl),
          const Align(
              alignment: Alignment.centerLeft,
              child: Text("Öncelik",
                  style: TextStyle(
                      fontSize: AppSizes.fontMd,
                      fontWeight: FontWeight.w500,
                      color: AppColors.softTextBlack))),
          const SizedBox(height: AppSizes.paddingSm),
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
          const SizedBox(height: AppSizes.paddingXl),
          const Align(
              alignment: Alignment.centerLeft,
              child: Text("Satın alınma durumu",
                  style: TextStyle(
                      fontSize: AppSizes.fontMd,
                      fontWeight: FontWeight.w500,
                      color: AppColors.softTextBlack))),
          const SizedBox(height: AppSizes.paddingSm),
          Row(
            children: [
              Expanded(
                  child: _buildStatusButton("Satın alındı",
                      selected: filter.status == PurchaseStatus.purchased,
                      onPressed: () =>
                          filterVM.setStatus(PurchaseStatus.purchased))),
              const SizedBox(width: AppSizes.paddingMd),
              Expanded(
                  child: _buildStatusButton("Satın alınmadı",
                      selected: filter.status == PurchaseStatus.notPurchased,
                      onPressed: () =>
                          filterVM.setStatus(PurchaseStatus.notPurchased))),
            ],
          ),
          const SizedBox(height: AppSizes.paddingXl),
          CustomPrimaryButton(
              text: "Filtreyi resetle",
              color: AppColors.lightGrey,
              textColor: AppColors.boldGreyText,
              hasShadow: false,
              onTap: () => filterVM.reset()),
          const SizedBox(height: AppSizes.paddingMd),
          CustomPrimaryButton(
              text: "Filtrele",
              hasShadow: false,
              onTap: () {
                filterVM.applyFilters();
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }

  Widget _buildExpandedChip(String label, IconData icon,
      {bool selected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: selected ? AppColors.primary : AppColors.lightGrey,
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
        color: selected ? AppColors.primary : AppColors.lightGrey,
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
        backgroundColor: selected ? AppColors.primary : AppColors.lightGrey,
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
