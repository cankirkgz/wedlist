import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wedlist/features/checklist/model/checklist_item_model.dart';

class ChecklistRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ChecklistItem>> getItems(String roomCode) async {
    final snapshot = await _firestore
        .collection('rooms')
        .doc(roomCode)
        .collection('items')
        .get();

    return snapshot.docs
        .map((doc) => ChecklistItem.fromMap(doc.id, doc.data()))
        .toList();
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

  Stream<List<ChecklistItem>> streamItems(String roomCode) {
    return _firestore
        .collection('rooms')
        .doc(roomCode)
        .collection('items')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ChecklistItem.fromMap(doc.id, doc.data()))
            .toList());
  }
}
