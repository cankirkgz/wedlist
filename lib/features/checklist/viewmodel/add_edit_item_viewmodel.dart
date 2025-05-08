import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wedlist/features/checklist/model/checklist_item_model.dart';

class AddEditItemViewModel extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final ValueNotifier<bool> purchasedController = ValueNotifier<bool>(false);

  String? selectedCategory;
  int priority = 3;

  final List<String> categoryList = [
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

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveItem(String roomId, String createdBy,
      {String? existingItemId}) async {
    if (roomId.isEmpty) {
      throw Exception("Geçersiz oda kimliği (roomId).");
    }

    final name = nameController.text.trim();
    final double? price = double.tryParse(priceController.text.trim());
    final isPurchased = purchasedController.value;

    if (name.isEmpty || selectedCategory == null) {
      throw Exception("Lütfen gerekli alanları doldurun.");
    }

    final ChecklistItem item = ChecklistItem(
      id: existingItemId ?? '', // doc id yalnızca update'te kullanılıyor
      name: name,
      category: selectedCategory!,
      priority: priority.toInt(),
      price: price,
      isChecked: isPurchased,
      createdBy: createdBy,
      createdAt: DateTime.now(),
    );

    final itemRef = FirebaseFirestore.instance
        .collection('rooms')
        .doc(roomId)
        .collection('items');

    if (existingItemId != null) {
      // 🔁 Güncelleme
      await itemRef.doc(existingItemId).update(item.toMap());
    } else {
      // 🆕 Yeni ekleme
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

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    purchasedController.dispose();
    super.dispose();
  }

  void populateFieldsFromItem(ChecklistItem item) {
    nameController.text = item.name;
    selectedCategory = item.category;
    priority = item.priority;
    priceController.text = item.price?.toString() ?? '';
    purchasedController.value = item.isChecked;
  }
}
