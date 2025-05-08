import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wedlist/features/checklist/model/checklist_item_model.dart';

class ChecklistRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Bir kerelik listeleme
  Future<List<ChecklistItem>> getItems(String roomCode) async {
    if (roomCode.isEmpty) return [];

    final snapshot = await _firestore
        .collection('rooms')
        .doc(roomCode)
        .collection('items')
        .orderBy('createdAt') // createdAt’a göre sırala
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
        .orderBy('createdAt') // createdAt’a göre sırala
        .snapshots()
        .handleError((error) {
      // Eğer stream’de bir hata olursa en azından konsola bas
      print("ChecklistRepository.streamItems error: $error");
    }).map((snapshot) => snapshot.docs
            .map((doc) => ChecklistItem.fromMap(doc.id, doc.data()))
            .toList());
  }

  Future<void> addItem(String roomCode, ChecklistItem item) async {
    await _firestore
        .collection('rooms')
        .doc(roomCode)
        .collection('items')
        .add(item.toMap());
  }

  Future<void> updateItem(String roomCode, ChecklistItem item) async {
    await _firestore
        .collection('rooms')
        .doc(roomCode)
        .collection('items')
        .doc(item.id)
        .update(item.toMap());
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
