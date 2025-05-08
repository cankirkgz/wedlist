import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wedlist/data/repository/checklist_repository.dart';
import 'package:wedlist/features/checklist/model/checklist_item_model.dart';
import 'package:wedlist/features/checklist/viewmodel/filter_viewmodel.dart';

class ChecklistViewModel extends Notifier<List<ChecklistItem>> {
  late final ChecklistRepository _repository;
  String _roomCode = '';
  List<ChecklistItem> _allItems = [];
  String _searchQuery = '';

  /// Harcanan toplam tutar
  double get spentTotal => _allItems
      .where((i) => i.isChecked)
      .fold(0.0, (sum, i) => sum + (i.price ?? 0));

  /// Kalan toplam tutar
  double get remainingTotal => _allItems
      .where((i) => !i.isChecked)
      .fold(0.0, (sum, i) => sum + (i.price ?? 0));

  /// Kalanın toplam içindeki oranı
  double get remainingPercentage {
    final total = spentTotal + remainingTotal;
    return total == 0 ? 0 : remainingTotal / total;
  }

  @override
  List<ChecklistItem> build() {
    _repository = ChecklistRepository();
    // Filtre veya arama değiştiğinde tekrar uygula
    ref.listen<FilterState>(filterProvider, (_, __) => _applyFilters());
    return [];
  }

  /// Oda kodunu set edip Firestore stream'ini başlat
  void setRoomCode(String code) {
    _roomCode = code;
    _repository.streamItems(code).listen((items) {
      _allItems = items;
      _applyFilters();
    });
  }

  /// Arama sorgusunu güncelle
  void setSearchQuery(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  Future<void> addItem(ChecklistItem item) =>
      _repository.addItem(_roomCode, item);

  Future<void> updateItem(ChecklistItem item) =>
      _repository.updateItem(_roomCode, item);

  Future<void> deleteItem(String id) => _repository.deleteItem(_roomCode, id);

  /// Filtre ve arama kriterlerini uygulayıp state'i günceller
  void _applyFilters() {
    final f = ref.read(filterProvider);

    var filtered = _allItems.where((item) {
      // 1) Kategori filtresi
      final byCategory = f.selectedCategory == null ||
          f.selectedCategory!.isEmpty ||
          item.category == f.selectedCategory;

      // 2) Öncelik filtresi
      final byPriority =
          f.selectedPriority == null || item.priority == f.selectedPriority;

      // 3) Durum filtresi
      final byStatus = f.status == PurchaseStatus.all ||
          (f.status == PurchaseStatus.purchased && item.isChecked) ||
          (f.status == PurchaseStatus.notPurchased && !item.isChecked);

      return byCategory && byPriority && byStatus;
    }).toList();

    // 4) Arama sorgusu
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      filtered = filtered
          .where((item) => item.name.toLowerCase().contains(q))
          .toList();
    }

    state = filtered;
  }
}
