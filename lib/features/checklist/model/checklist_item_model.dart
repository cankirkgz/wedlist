import 'package:cloud_firestore/cloud_firestore.dart';

class ChecklistItem {
  final String id;
  final String name;
  final String category;
  final int priority;
  final double? price;
  final bool isPurchased;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isSynced;

  ChecklistItem({
    required this.id,
    required this.name,
    required this.category,
    required this.priority,
    this.price,
    required this.isPurchased,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.isSynced,
  });

  factory ChecklistItem.fromMap(String id, Map<String, dynamic> map) {
    final isPurchasedValue = map['isPurchased'];

    return ChecklistItem(
      id: id,
      name: map['name'] as String? ?? '',
      category: map['category'] as String? ?? '',
      priority: map['priority'] as int? ?? 1,
      price: (map['price'] as num?)?.toDouble(),
      isPurchased: isPurchasedValue == true,
      createdBy: map['createdBy'] as String? ?? '',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (map['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      isSynced: map['isSynced'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'priority': priority,
      'price': price,
      'isPurchased': isPurchased,
      'createdBy': createdBy,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'isSynced': isSynced,
    };
  }

  ChecklistItem copyWith({
    String? id,
    String? name,
    String? category,
    int? priority,
    double? price,
    bool? isPurchased,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isSynced,
  }) {
    return ChecklistItem(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      price: price ?? this.price,
      isPurchased: isPurchased ?? this.isPurchased,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isSynced: isSynced ?? this.isSynced,
    );
  }
}
