import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

part 'checklist_item_model.g.dart';

@HiveType(typeId: 0)
class ChecklistItem {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String category;

  @HiveField(3)
  final int priority;

  @HiveField(4)
  final double? price;

  @HiveField(5)
  final bool isPurchased;

  @HiveField(6)
  final String createdBy;

  @HiveField(7)
  final DateTime createdAt;

  @HiveField(8)
  final DateTime updatedAt;

  @HiveField(9)
  final bool isSynced;

  @HiveField(10)
  final String roomCode;

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
    required this.roomCode,
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
      roomCode: map['roomCode'] as String? ?? '',
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
      'roomCode': roomCode,
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
    String? roomCode,
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
      roomCode: roomCode ?? this.roomCode,
    );
  }
}
