import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:wedlist/core/constants/app_colors.dart';
import 'package:wedlist/core/constants/app_sizes.dart';

class ItemCard extends StatefulWidget {
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

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  late bool isBought;

  @override
  void initState() {
    super.initState();
    isBought = widget.isBought;
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => widget.onEdit(),
            backgroundColor: AppColors.blue,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: '',
          ),
          SlidableAction(
            onPressed: (_) => widget.onDelete(),
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
          margin:
              const EdgeInsets.symmetric(vertical: 10), // spacing between items
          padding: const EdgeInsets.all(12),
          constraints: const BoxConstraints(
              minHeight: AppSizes.heightSemiHuge), // increased height
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment:
                CrossAxisAlignment.center, // checkbox vertical center
            children: [
              GestureDetector(
                onTap: () {
                  setState(() => isBought = !isBought);
                  widget.onCheckToggle(isBought);
                },
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: isBought ? AppColors.blue : Colors.transparent,
                    border: Border.all(color: AppColors.primaryText),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: isBought
                      ? const Icon(Icons.check, color: Colors.white, size: 16)
                      : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textBlack,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.buttonSoftPrimary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            widget.category,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.primaryText,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        RatingBarIndicator(
                          rating: widget.rating,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 18.0,
                          unratedColor: AppColors.lightGrey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '₺${widget.price.toStringAsFixed(0)}',
                style: const TextStyle(
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
