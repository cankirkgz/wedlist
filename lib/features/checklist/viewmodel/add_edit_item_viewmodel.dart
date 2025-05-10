import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wedlist/features/checklist/model/checklist_item_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddEditItemViewModel extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final ValueNotifier<bool> purchasedController = ValueNotifier<bool>(false);

  String? selectedCategory;
  int priority = 3;

  // Lokalize kategori listesi (UI'da gösterim için)
  List<String> getCategoryList(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return [
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
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveItem(BuildContext context, String roomId, String createdBy,
      {String? existingItemId}) async {
    final t = AppLocalizations.of(context)!;

    if (roomId.isEmpty) {
      throw Exception(t.invalidRoomId);
    }

    final name = nameController.text.trim();
    final double? price = double.tryParse(priceController.text.trim());
    final isPurchased = purchasedController.value;

    if (name.isEmpty || selectedCategory == null) {
      throw Exception(t.pleaseFillRequiredFields);
    }

    final ChecklistItem item = ChecklistItem(
      id: existingItemId ?? '',
      name: name,
      category: selectedCategory!,
      priority: priority,
      price: price,
      isPurchased: isPurchased,
      createdBy: createdBy,
      createdAt: DateTime.now(),
    );

    final itemRef =
        _firestore.collection('rooms').doc(roomId).collection('items');

    if (existingItemId != null) {
      await itemRef.doc(existingItemId).update(item.toMap());
    } else {
      await itemRef.add(item.toMap());
    }
  }

  void resetFields() {
    nameController.clear();
    priceController.clear();
    selectedCategory = null;
    priority = 3;
    purchasedController.value = false;
    notifyListeners();
  }

  void populateFieldsFromItem(ChecklistItem item) {
    nameController.text = item.name;
    selectedCategory = item.category;
    priority = item.priority;
    priceController.text = item.price?.toString() ?? '';
    purchasedController.value = item.isPurchased;
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    purchasedController.dispose();
    super.dispose();
  }
}
