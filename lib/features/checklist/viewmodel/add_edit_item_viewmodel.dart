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

  Future<void> saveItem(String roomId, String createdBy) async {
    print("ROOM: " + roomId);
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
      id: '', // Firestore otomatik ID atayacak
      name: name,
      category: selectedCategory!,
      priority: priority,
      price: price,
      isChecked: isPurchased,
      createdBy: createdBy,
      createdAt: DateTime.now(),
    );

    await _firestore
        .collection('rooms')
        .doc(roomId)
        .collection('items')
        .add(item.toMap());
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
}
