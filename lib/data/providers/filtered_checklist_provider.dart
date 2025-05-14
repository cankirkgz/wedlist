import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wedlist/data/providers/checklist_provider.dart';
import 'package:wedlist/data/providers/search_query_provider.dart';
import 'package:wedlist/features/checklist/viewmodel/filter_viewmodel.dart';
import 'package:wedlist/features/checklist/model/checklist_item_model.dart';

/// Filtreleme ve arama işlemlerini bir arada yaparak sonuç döner
final filteredChecklistProvider = Provider<List<ChecklistItem>>((ref) {
  final asyncItems = ref.watch(checklistProvider);
  final filter = ref.watch(filterProvider);
  final query = ref.watch(searchQueryProvider).toLowerCase();

  return asyncItems.when(
    data: (items) {
      final result = items.where((item) {
        final matchesCategory = filter.selectedCategory?.isEmpty != false ||
            item.category == filter.selectedCategory;

        final matchesPriority = filter.selectedPriority == null ||
            item.priority == filter.selectedPriority;

        final matchesStatus = filter.status == PurchaseStatus.all ||
            (filter.status == PurchaseStatus.purchased && item.isPurchased) ||
            (filter.status == PurchaseStatus.notPurchased && !item.isPurchased);

        final matchesQuery =
            query.isEmpty || item.name.toLowerCase().contains(query);

        return matchesCategory &&
            matchesPriority &&
            matchesStatus &&
            matchesQuery;
      }).toList();

      // Satın alınmamış olanlar üstte, sonra tarihe göre sırala
      result.sort((a, b) {
        if (a.isPurchased == b.isPurchased) {
          return a.createdAt.compareTo(b.createdAt);
        }
        return a.isPurchased ? 1 : -1;
      });

      if (kDebugMode) {
        print('📋 Filtreleme tamamlandı: ${result.length} item bulundu');
      }

      return result;
    },
    loading: () => [],
    error: (e, _) {
      if (kDebugMode) {
        print('❌ Filtreleme hatası: $e');
      }
      return [];
    },
  );
});
