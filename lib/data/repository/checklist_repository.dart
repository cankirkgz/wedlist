import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:wedlist/features/checklist/model/checklist_item_model.dart';

class ChecklistRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Box<ChecklistItem> _hiveBox = Hive.box<ChecklistItem>('items');

  Future<List<ChecklistItem>> getLocalItems(String roomCode) async {
    return _hiveBox.values.where((item) => item.roomCode == roomCode).toList();
  }

  Future<void> saveToHive(ChecklistItem item) async {
    await _hiveBox.put(item.id, item);
  }

  Stream<List<ChecklistItem>> streamItems(String roomCode) {
    if (roomCode.isEmpty) return const Stream.empty();

    return _firestore
        .collection('rooms')
        .doc(roomCode)
        .collection('items')
        .orderBy('createdAt')
        .snapshots()
        .handleError((error) {
      print("ChecklistRepository.streamItems error: $error");
    }).map((snapshot) {
      final sortedDocs = snapshot.docs.toList()
        ..sort((a, b) {
          final aPurchased = a.data()['isPurchased'] as bool;
          final bPurchased = b.data()['isPurchased'] as bool;

          if (aPurchased == bPurchased) {
            final aTime =
                (a.data()['createdAt'] as Timestamp).millisecondsSinceEpoch;
            final bTime =
                (b.data()['createdAt'] as Timestamp).millisecondsSinceEpoch;
            return aTime.compareTo(bTime);
          }

          return aPurchased ? 1 : -1;
        });

      final items = sortedDocs.map((doc) {
        final item = ChecklistItem.fromMap(doc.id, doc.data());
        // 🔁 Hive'a yaz (senkron olarak işaretle)
        _hiveBox.put(item.id, item.copyWith(isSynced: true));
        return item;
      }).toList();

      return items;
    });
  }

  Future<void> addItem(String roomCode, ChecklistItem item) async {
    try {
      final docRef = await _firestore
          .collection('rooms')
          .doc(roomCode)
          .collection('items')
          .doc(item.id);
      await docRef.set(item.toMap());
      await _hiveBox.put(item.id, item.copyWith(isSynced: true));
    } catch (_) {
      await _hiveBox.put(item.id, item.copyWith(isSynced: false));
    }
  }

  Future<void> updateItem(String roomCode, ChecklistItem item) async {
    try {
      await _firestore
          .collection('rooms')
          .doc(roomCode)
          .collection('items')
          .doc(item.id)
          .update(item.toMap());
      await _hiveBox.put(item.id, item.copyWith(isSynced: true));
    } catch (_) {
      await _hiveBox.put(item.id, item.copyWith(isSynced: false));
    }
  }

  Future<void> deleteItem(String roomCode, String itemId) async {
    try {
      await _firestore
          .collection('rooms')
          .doc(roomCode)
          .collection('items')
          .doc(itemId)
          .delete();
      await _hiveBox.delete(itemId);
    } catch (_) {
      // Silme offline yapılmışsa sadece Hive'dan silinir
      await _hiveBox.delete(itemId);
    }
  }

  /// 🔁 Offline item'ları Firestore'a gönder
  Future<void> syncUnsyncedItems(String roomCode) async {
    final unsyncedItems = _hiveBox.values
        .where((item) => !item.isSynced && item.roomCode == roomCode)
        .toList();

    for (var item in unsyncedItems) {
      final docRef = _firestore
          .collection('rooms')
          .doc(roomCode)
          .collection('items')
          .doc(item.id);
      await docRef.set(item.toMap());
      await _hiveBox.put(item.id, item.copyWith(isSynced: true));
    }
  }
}
