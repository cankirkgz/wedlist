import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wedlist/data/providers/checklist_provider.dart';
import 'package:wedlist/data/providers/search_query_provider.dart';
import 'package:wedlist/features/checklist/viewmodel/filter_viewmodel.dart';
import 'package:wedlist/features/checklist/model/checklist_item_model.dart';

/// Tüm öğeleri + filtre durumunu + arama sorgusunu bir arada süzerek döner
final filteredChecklistProvider = Provider<List<ChecklistItem>>((ref) {
  final asyncItems = ref.watch(checklistProvider);
  final filter = ref.watch(filterProvider);
  final query = ref.watch(searchQueryProvider).toLowerCase();

  return asyncItems.when(
    data: (items) {
      print('Filtreleme başlıyor...');
      print('Toplam item sayısı: ${items.length}');
      print('Seçili kategori: ${filter.selectedCategory}');
      print('Seçili öncelik: ${filter.selectedPriority}');
      print('Seçili durum: ${filter.status}');
      print('Arama sorgusu: $query');

      // Önce tüm itemları kopyala ve sıralamayı koru
      final filtered = List<ChecklistItem>.from(items);

      // Filtreleme işlemlerini uygula
      final result = filtered.where((item) {
        // 1. Kategori filtresi
        if (filter.selectedCategory?.isNotEmpty == true &&
            item.category != filter.selectedCategory) {
          return false;
        }

        // 2. Öncelik filtresi
        if (filter.selectedPriority != null &&
            item.priority != filter.selectedPriority) {
          return false;
        }

        // 3. Satın alma durumu filtresi
        if (filter.status == PurchaseStatus.purchased && !item.isPurchased) {
          return false;
        }
        if (filter.status == PurchaseStatus.notPurchased && item.isPurchased) {
          return false;
        }

        // 4. Arama filtresi
        if (query.isNotEmpty && !item.name.toLowerCase().contains(query)) {
          return false;
        }

        return true;
      }).toList();

      print('Filtreleme sonrası item sayısı: ${result.length}');
      print('Filtrelenen itemlar:');
      for (var item in result) {
        print('${item.name} - isPurchased: ${item.isPurchased}');
      }

      // Filtreleme sonrası sıralamayı koru
      result.sort((a, b) {
        if (a.isPurchased == b.isPurchased) {
          return a.createdAt.compareTo(b.createdAt);
        }
        return a.isPurchased ? 1 : -1;
      });

      return result;
    },
    loading: () => [],
    error: (e, _) {
      print('Filtreleme hatası: $e');
      return [];
    },
  );
});
