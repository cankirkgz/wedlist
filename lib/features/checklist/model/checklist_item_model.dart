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

  ChecklistItem({
    required this.id,
    required this.name,
    required this.category,
    required this.priority,
    this.price,
    required this.isPurchased,
    required this.createdBy,
    required this.createdAt,
  });

  factory ChecklistItem.fromMap(String id, Map<String, dynamic> map) {
    final isPurchasedValue = map['isPurchased'];
    print("Model dönüşümü - ID: $id");
    print("Ham isPurchased değeri: $isPurchasedValue");
    print("Ham isPurchased tipi: ${isPurchasedValue.runtimeType}");

    final isPurchased = isPurchasedValue == true;
    print("Dönüştürülmüş isPurchased değeri: $isPurchased");
    print("-------------------");

    // Kategori standardizasyonu
    String standardizeCategory(String category) {
      final Map<String, String> categoryMap = {
        'Mutfak': 'Mutfak',
        'Banyo': 'Banyo',
        'Yatak Odası': 'Yatak Odası',
        'Salon': 'Salon',
        'Çalışma Odası': 'Çalışma Odası',
        'Balkon / Bahçe': 'Balkon / Bahçe',
        'Elektronik': 'Elektronik',
        'Temizlik Ürünleri': 'Temizlik Ürünleri',
        'Kişisel Bakım': 'Kişisel Bakım',
        'Dekorasyon': 'Dekorasyon',
        'Diğer': 'Diğer',
      };

      return categoryMap[category] ?? 'Diğer';
    }

    return ChecklistItem(
      id: id,
      name: map['name'] as String? ?? '',
      category: standardizeCategory(map['category'] as String? ?? 'Diğer'),
      priority: map['priority'] as int? ?? 1,
      price: (map['price'] as num?)?.toDouble(),
      isPurchased: isPurchased,
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
      'isPurchased': isPurchased,
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
    bool? isPurchased,
    String? createdBy,
    DateTime? createdAt,
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
    );
  }
}
