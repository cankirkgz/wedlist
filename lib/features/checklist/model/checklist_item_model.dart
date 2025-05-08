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
      name: map['name'] as String? ?? '',
      category: map['category'] as String? ?? '',
      priority: map['priority'] as int? ?? 1,
      price: (map['price'] as num?)?.toDouble(),
      isChecked: map['isChecked'] as bool? ?? false,
      createdBy: map['createdBy'] as String? ?? '',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
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
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  ChecklistItem copyWith({
    String? id,
    String? name,
    String? category,
    int? priority,
    double? price,
    bool? isChecked,
    String? createdBy,
    DateTime? createdAt,
  }) {
    return ChecklistItem(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      price: price ?? this.price,
      isChecked: isChecked ?? this.isChecked,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
