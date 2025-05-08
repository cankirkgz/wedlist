import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wedlist/data/providers/checklist_provider.dart';
import 'package:wedlist/features/checklist/model/checklist_item_model.dart';
import 'package:wedlist/features/checklist/viewmodel/filter_viewmodel.dart';

/// Tüm öğeleri filtre kriterlerine göre süzerek döner
final filteredChecklistProvider = Provider<List<ChecklistItem>>((ref) {
  final allItems = ref.watch(checklistProvider);
  final filter = ref.watch(filterProvider);

  return allItems.where((item) {
    // Kategori filtresi
    final byCategory = filter.selectedCategory == null ||
        filter.selectedCategory!.isEmpty ||
        item.category == filter.selectedCategory;

    // Öncelik filtresi
    final byPriority = filter.selectedPriority == null ||
        item.priority == filter.selectedPriority;

    // Satın alma durumu filtresi
    final byStatus = filter.status == PurchaseStatus.all ||
        (filter.status == PurchaseStatus.purchased && item.isChecked) ||
        (filter.status == PurchaseStatus.notPurchased && !item.isChecked);

    return byCategory && byPriority && byStatus;
  }).toList();
});
