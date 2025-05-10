import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wedlist/data/providers/checklist_provider.dart';
import 'package:wedlist/data/providers/search_query_provider.dart';
import 'package:wedlist/features/checklist/viewmodel/filter_viewmodel.dart';
import 'package:wedlist/features/checklist/model/checklist_item_model.dart';

/// Tüm öğeleri + filtre durumunu + arama sorgusunu bir arada süzerek döner
final filteredChecklistProvider = Provider<List<ChecklistItem>>((ref) {
  final allItems = ref.watch(checklistProvider); // Firestore akışı
  final filter = ref.watch(filterProvider); // kategori/öncelik/durum
  final searchQuery = ref.watch(searchQueryProvider).toLowerCase();

  return allItems.where((item) {
    // 1) Kategori
    if (filter.selectedCategory != null &&
        filter.selectedCategory!.isNotEmpty &&
        item.category != filter.selectedCategory) {
      return false;
    }

    // 2) Öncelik
    if (filter.selectedPriority != null &&
        item.priority != filter.selectedPriority) {
      return false;
    }

    // 3) Satın alma durumu
    if (filter.status == PurchaseStatus.purchased && !item.isChecked) {
      return false;
    }
    if (filter.status == PurchaseStatus.notPurchased && item.isChecked) {
      return false;
    }

    // 4) Arama
    if (searchQuery.isNotEmpty &&
        !item.name.toLowerCase().contains(searchQuery)) {
      return false;
    }

    return true;
  }).toList();
});
