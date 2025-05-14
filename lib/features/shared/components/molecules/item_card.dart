import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:wedlist/core/constants/app_colors.dart';
import 'package:wedlist/core/constants/app_sizes.dart';

class ItemCard extends StatelessWidget {
  final String name;
  final String category;
  final double price;
  final double rating;
  final bool isBought;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final ValueChanged<bool> onCheckToggle;

  const ItemCard({
    super.key,
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    required this.isBought,
    required this.onEdit,
    required this.onDelete,
    required this.onCheckToggle,
  });

  String _getCurrencySymbol(String languageCode) {
    switch (languageCode) {
      case 'tr':
        return '₺';
      case 'en':
        return '\$';
      case 'de':
        return '€';
      case 'ru':
        return '₽';
      default:
        return '\$';
    }
  }

  @override
  Widget build(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;
    final currencySymbol = _getCurrencySymbol(languageCode);

    return Slidable(
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => onEdit(),
            backgroundColor: AppColors.blue,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: '',
          ),
          SlidableAction(
            onPressed: (_) => onDelete(),
            backgroundColor: AppColors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: '',
          ),
        ],
      ),
      child: Opacity(
        opacity: isBought ? 0.5 : 1,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8.h),
          padding: EdgeInsets.all(8.w),
          constraints: BoxConstraints(minHeight: 80.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 8.w),
              GestureDetector(
                onTap: () => onCheckToggle(!isBought),
                child: Container(
                  width: 24.w,
                  height: 24.w,
                  decoration: BoxDecoration(
                    color: isBought ? AppColors.blue : Colors.transparent,
                    border: Border.all(color: AppColors.primaryText),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: isBought
                      ? const Icon(Icons.check, color: Colors.white, size: 16)
                      : null,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textBlack,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 3.h,
                            horizontal: 6.w,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.buttonSoftPrimary,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            category,
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: AppColors.primaryText,
                            ),
                          ),
                        ),
                        SizedBox(width: 6.w),
                        RatingBarIndicator(
                          rating: rating,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 16.w,
                          unratedColor: AppColors.lightGrey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                '$currencySymbol${price.toStringAsFixed(0)}',
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
