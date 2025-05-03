class ChecklistItem {
  final String id;
  final String name;
  final String category;
  final int priority;
  final double? price;
  final bool isChecked;

  ChecklistItem({
    required this.id,
    required this.name,
    required this.category,
    required this.priority,
    this.price,
    required this.isChecked,
  });

  factory ChecklistItem.fromMap(String id, Map<String, dynamic> map) {
    return ChecklistItem(
      id: id,
      name: map['name'] ?? '',
      category: map['category'] ?? '',
      priority: map['priority'] ?? 1,
      price: (map['price'] as num?)?.toDouble(),
      isChecked: map['isChecked'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'priority': priority,
      'price': price,
      'isChecked': isChecked,
    };
  }
}
