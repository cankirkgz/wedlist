import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:wedlist/data/services/local_item_service.dart';
import 'package:wedlist/data/services/firestore_service.dart';

class SyncService {
  final LocalItemService _localItemService;
  final FirestoreService _firestoreService;

  SyncService(this._localItemService, this._firestoreService);

  /// 🔁 Offline kayıtlı ve senkronize edilmemiş verileri Firebase ile eşitle
  Future<void> syncUnsyncedItems(String roomId) async {
    final connectivity = await Connectivity().checkConnectivity();

    if (connectivity == ConnectivityResult.none) {
      return; // Eğer offline isek çık
    }

    final unsyncedItems = _localItemService.getUnsyncedItems(roomId);

    for (final item in unsyncedItems) {
      try {
        if (item.id.isNotEmpty) {
          // Güncelleme ise
          await _firestoreService.updateItem(
              roomId, item.copyWith(isSynced: true));
        } else {
          // Yeni eklenmişse
          final newId = await _firestoreService.addItem(
              roomId, item.copyWith(isSynced: true));
          final updatedItem = item.copyWith(id: newId, isSynced: true);
          await _localItemService.updateItem(updatedItem);
        }
        // Başarılıysa local'de isSynced'i true yap
        await _localItemService.updateItem(item.copyWith(isSynced: true));
      } catch (e) {
        print('Sync hatası: ${e.toString()}');
      }
    }
  }
}
