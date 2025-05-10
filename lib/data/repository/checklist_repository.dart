import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wedlist/features/checklist/model/checklist_item_model.dart';

class ChecklistRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ChecklistItem>> getItems(String roomCode) async {
    if (roomCode.isEmpty) return [];

    final snapshot = await _firestore
        .collection('rooms')
        .doc(roomCode)
        .collection('items')
        .orderBy('createdAt')
        .get();

    final list = snapshot.docs
        .map((doc) => ChecklistItem.fromMap(doc.id, doc.data()))
        .toList();

    print("ChecklistRepository.getItems → Room: $roomCode, items: $list");
    return list;
  }

  /// Gerçek zamanlı dinleme
  Stream<List<ChecklistItem>> streamItems(String roomCode) {
    if (roomCode.isEmpty) {
      // Geçersiz roomCode geldiğinde boş stream dön
      return const Stream.empty();
    }

    return _firestore
        .collection('rooms')
        .doc(roomCode)
        .collection('items')
        .orderBy('createdAt')
        .snapshots()
        .handleError((error) {
      print("ChecklistRepository.streamItems error: $error");
    }).map((snapshot) {
      print("Firestore'dan gelen ham veriler:");
      for (var doc in snapshot.docs) {
        print("Item ID: ${doc.id}");
        print("Item Data: ${doc.data()}");
        print("isPurchased değeri: ${doc.data()['isPurchased']}");
        print("isPurchased tipi: ${doc.data()['isPurchased'].runtimeType}");
        print("-------------------");
      }

      // Önce isPurchased'a göre sırala, sonra createdAt'e göre
      final sortedDocs = snapshot.docs.toList()
        ..sort((a, b) {
          final aPurchased = a.data()['isPurchased'] as bool;
          final bPurchased = b.data()['isPurchased'] as bool;

          if (aPurchased == bPurchased) {
            // isPurchased değerleri aynıysa createdAt'e göre sırala
            final aTime =
                (a.data()['createdAt'] as Timestamp).millisecondsSinceEpoch;
            final bTime =
                (b.data()['createdAt'] as Timestamp).millisecondsSinceEpoch;
            return aTime.compareTo(bTime);
          }

          // isPurchased değerleri farklıysa false olanlar önce gelsin
          return aPurchased ? 1 : -1;
        });

      return sortedDocs
          .map((doc) => ChecklistItem.fromMap(doc.id, doc.data()))
          .toList();
    });
  }

  Future<void> addItem(String roomCode, ChecklistItem item) async {
    await _firestore
        .collection('rooms')
        .doc(roomCode)
        .collection('items')
        .add(item.toMap());
  }

  Future<void> updateItem(String roomCode, ChecklistItem item) async {
    print("Repository - Güncelleme başlıyor");
    print("Room Code: $roomCode");
    print("Item ID: ${item.id}");
    print("Güncellenecek veri: ${item.toMap()}");

    try {
      final docRef = _firestore
          .collection('rooms')
          .doc(roomCode)
          .collection('items')
          .doc(item.id);

      final data = item.toMap();
      print("Firestore'a gönderilecek veri: $data");

      await docRef.update(data);
      print("Repository - Güncelleme başarılı");
    } catch (e) {
      print("Repository - Güncelleme hatası: $e");
      rethrow;
    }
  }

  Future<void> deleteItem(String roomCode, String itemId) async {
    await _firestore
        .collection('rooms')
        .doc(roomCode)
        .collection('items')
        .doc(itemId)
        .delete();
  }
}
