import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedlist/app/providers.dart';
import 'package:wedlist/core/constants/app_colors.dart';
import 'package:wedlist/core/constants/app_sizes.dart';
import 'package:wedlist/data/providers/add_edit_item_provider.dart';
import 'package:wedlist/data/providers/auth_provider.dart';
import 'package:wedlist/features/checklist/model/checklist_item_model.dart';
import 'package:wedlist/features/shared/components/atoms/custom_primary_button.dart';
import 'package:wedlist/features/shared/components/atoms/labeled_switch.dart';
import 'package:wedlist/features/shared/components/molecules/labeled_dropdown_field.dart';
import 'package:wedlist/features/shared/components/molecules/labeled_text_field.dart';
import 'package:wedlist/features/shared/components/molecules/priority_rating_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class AddEditItemScreen extends ConsumerStatefulWidget {
  final String roomId;
  final ChecklistItem? item;

  const AddEditItemScreen({
    super.key,
    @PathParam('roomId') required this.roomId,
    this.item,
  });

  @override
  ConsumerState<AddEditItemScreen> createState() => _AddEditItemScreenState();
}

class _AddEditItemScreenState extends ConsumerState<AddEditItemScreen> {
  IconData _getCurrencyIcon(String languageCode) {
    switch (languageCode) {
      case 'tr':
        return Icons.currency_lira;
      case 'en':
        return Icons.attach_money;
      case 'de':
        return Icons.euro;
      case 'ru':
        return Icons.currency_ruble;
      default:
        return Icons.attach_money;
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final viewModel = ref.read(addEditItemViewModelProvider);
      viewModel.resetFields();
      if (widget.item != null) {
        viewModel.populateFieldsFromItem(widget.item!);
      }
    });
  }

  void _saveItem(AppLocalizations t) async {
    final viewModel = ref.read(addEditItemViewModelProvider);
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      _showError(t.userSessionNotFound);
      return;
    }

    bool isOfflineHandled = false;

    try {
      await viewModel.saveItem(
        context,
        widget.roomId,
        userId,
        existingItemId: widget.item?.id,
        originalCreatedAt: widget.item?.createdAt,
        onLocalSave: (item) async {
          ref.read(checklistProvider.notifier).addOrUpdateLocalItem(
                item.copyWith(isSynced: false),
              );

          // ✅ Eğer offline kayıt yapıldıysa burada sayfayı kapat
          if (!isOfflineHandled && context.mounted) {
            context.router.pop();
            isOfflineHandled = true; // bir daha pop olmasın
          }
        },
      );

      // ✅ Eğer internet vardıysa (onLocalSave pop etmediyse), burada çık
      if (!isOfflineHandled && context.mounted) {
        context.router.pop();
      }
    } catch (e) {
      _showError(e.toString().replaceAll(t.exceptionLabel, ''));
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(addEditItemViewModelProvider);
    final t = AppLocalizations.of(context)!;
    final categories = viewModel.getCategoryList(context);
    final languageCode = Localizations.localeOf(context).languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.item == null ? t.addProduct : t.editProduct,
          style: GoogleFonts.inter(
            fontWeight: AppSizes.weightBold,
            color: AppColors.textBlack,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppSizes.paddingLg,
            horizontal: AppSizes.paddingXl,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LabeledTextField(
                  label: t.productName,
                  hintText: t.productExample,
                  controller: viewModel.nameController,
                ),
                SizedBox(height: AppSizes.paddingXl),
                LabeledDropdownField(
                  label: t.category,
                  selectedValue: viewModel.selectedCategory,
                  items: categories,
                  onChanged: (value) {
                    setState(() {
                      viewModel.selectedCategory = value;
                    });
                  },
                ),
                SizedBox(height: AppSizes.paddingXl),
                PriorityRatingBar(
                  value: viewModel.priority,
                  onChanged: (value) => viewModel.priority = value,
                ),
                SizedBox(height: AppSizes.paddingXl),
                LabeledTextField(
                  label: t.priceOptional,
                  hintText: t.priceExample,
                  controller: viewModel.priceController,
                  prefixIcon: _getCurrencyIcon(languageCode),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: AppSizes.paddingXl),
                LabeledSwitch(
                  label: t.markAsPurchased,
                  controller: viewModel.purchasedController,
                ),
                SizedBox(height: AppSizes.paddingXl * 2),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: AppColors.white,
        padding: EdgeInsets.all(AppSizes.paddingLg),
        child: CustomPrimaryButton(
          text: t.save,
          onTap: () => _saveItem(t),
        ),
      ),
    );
  }
}
