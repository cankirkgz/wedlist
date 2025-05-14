import 'package:hive/hive.dart';
import 'package:wedlist/features/checklist/model/checklist_item_model.dart';

class LocalItemService {
  static const _boxName = 'items';
  final Box<ChecklistItem> _box = Hive.box<ChecklistItem>(_boxName);

  /// ✅ Tüm ürünleri getir (belirli bir oda için)
  List<ChecklistItem> getItemsForRoom(String roomId) {
    return _box.values.where((item) => item.createdBy == roomId).toList();
  }

  /// ✅ Yeni ürün kaydet
  Future<void> saveItem(ChecklistItem item) async {
    await _box.put(item.id, item);
  }

  /// ✅ Var olan ürünü güncelle
  Future<void> updateItem(ChecklistItem item) async {
    await _box.put(item.id, item);
  }

  /// ✅ Ürün sil
  Future<void> deleteItem(String id) async {
    await _box.delete(id);
  }

  /// 🔄 Firebase'e henüz senkronize edilmemiş ürünleri getir
  List<ChecklistItem> getUnsyncedItems(String roomId) {
    return _box.values
        .where((item) => item.createdBy == roomId && !item.isSynced)
        .toList();
  }

  /// 🧹 Tüm verileri sil (isteğe bağlı)
  Future<void> clearAll() async {
    await _box.clear();
  }
}
