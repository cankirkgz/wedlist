import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
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

  void _saveItem() async {
    final viewModel = ref.read(addEditItemViewModelProvider);
    final authViewModel = ref.read(authProvider.notifier);
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      _showError("Kullanıcı oturumu bulunamadı.");
      return;
    }

    try {
      final roomId = await authViewModel.fetchRoomId();
      await viewModel.saveItem(
        roomId ?? "",
        userId,
        existingItemId: widget.item?.id,
      );
      context.router.back();
    } catch (e) {
      _showError(e.toString().replaceAll('Exception: ', ''));
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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.item == null ? "Ürün Ekle" : "Ürünü Düzenle",
          style: GoogleFonts.inter(
            fontWeight: AppSizes.weightBold,
            color: AppColors.textBlack,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSizes.paddingLg,
            horizontal: AppSizes.paddingXl,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LabeledTextField(
                  label: "Ürün Adı",
                  hintText: "örn. Tost Makinesi",
                  controller: viewModel.nameController,
                ),
                const SizedBox(height: AppSizes.paddingXl),
                LabeledDropdownField(
                  label: "Kategori",
                  selectedValue: viewModel.selectedCategory,
                  items: viewModel.categoryList,
                  onChanged: (value) {
                    setState(() {
                      viewModel.selectedCategory = value;
                    });
                  },
                ),
                const SizedBox(height: AppSizes.paddingXl),
                PriorityRatingBar(
                  value: viewModel.priority,
                  onChanged: (value) => viewModel.priority = value,
                ),
                const SizedBox(height: AppSizes.paddingXl),
                LabeledTextField(
                  label: "Fiyatı (opsiyonel)",
                  hintText: "örn. 2500 ₺",
                  controller: viewModel.priceController,
                  prefixIcon: Icons.currency_lira,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: AppSizes.paddingXl),
                LabeledSwitch(
                  label: "Satın alındı olarak işaretle",
                  controller: viewModel.purchasedController,
                ),
                const SizedBox(height: AppSizes.paddingXl * 2),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: AppColors.white,
        padding: const EdgeInsets.all(AppSizes.paddingLg),
        child: CustomPrimaryButton(
          text: 'Kaydet',
          onTap: _saveItem,
        ),
      ),
    );
  }
}
