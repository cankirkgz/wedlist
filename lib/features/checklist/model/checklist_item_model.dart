import 'package:cloud_firestore/cloud_firestore.dart';

class ChecklistItem {
  final String id;
  final String name;
  final String category;
  final int priority;
  final double? price;
  final bool isChecked;
  final String createdBy;
  final DateTime createdAt;

  ChecklistItem({
    required this.id,
    required this.name,
    required this.category,
    required this.priority,
    this.price,
    required this.isChecked,
    required this.createdBy,
    required this.createdAt,
  });

  factory ChecklistItem.fromMap(String id, Map<String, dynamic> map) {
    return ChecklistItem(
      id: id,
      name: map['name'] ?? '',
      category: map['category'] ?? '',
      priority: map['priority'] ?? 1,
      price: (map['price'] as num?)?.toDouble(),
      isChecked: map['isChecked'] ?? false,
      createdBy: map['createdBy'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'priority': priority,
      'price': price,
      'isChecked': isChecked,
      'createdBy': createdBy,
      'createdAt': createdAt,
    };
  }
}
