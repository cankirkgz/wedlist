import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wedlist/features/auth/model/user_model.dart';
import 'package:wedlist/features/checklist/model/checklist_item_model.dart';
import 'package:wedlist/features/room/model/room_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Kullanıcıyı Firestore'a kaydet
  Future<void> createUser({
    required String userId,
    required UserModel user,
  }) async {
    await _firestore.collection('users').doc(userId).set(user.toJson());
  }

  // Belirli kullanıcıyı getir
  Future<UserModel?> getUser(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    if (doc.exists) {
      return UserModel.fromJson(doc.data()!);
    }
    return null;
  }

  // Kullanıcıyı güncelle
  Future<void> updateUser({
    required String userId,
    required Map<String, dynamic> data,
  }) async {
    await _firestore.collection('users').doc(userId).update(data);
  }

  // Kullanıcıyı sil
  Future<void> deleteUser(String userId) async {
    await _firestore.collection('users').doc(userId).delete();
  }

  // Tüm kullanıcıları stream olarak al (dinamik değişim için)
  Stream<List<UserModel>> getUsersStream() {
    return _firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => UserModel.fromJson(doc.data()))
          .toList();
    });
  }

  // Oda oluşturma
  Future<DocumentReference> createRoom(RoomModel room, String roomCode) {
    final docRef = FirebaseFirestore.instance.collection('rooms').doc(roomCode);
    return docRef.set(room.toJson()).then((_) => docRef);
  }

  Future<DocumentSnapshot?> getRoomByCode(String code) async {
    final snapshot = await _firestore
        .collection('rooms')
        .where(FieldPath.documentId, isEqualTo: code)
        .limit(1)
        .get();
    return snapshot.docs.isEmpty ? null : snapshot.docs.first;
  }

  Future<void> addUserToRoom(String roomId, String userId) async {
    await _firestore.collection('rooms').doc(roomId).update({
      'participants': FieldValue.arrayUnion([userId])
    });
  }

  Future<void> joinRoom(String roomCode, String userId) async {
    await _firestore.collection('rooms').doc(roomCode).update({
      'participants': FieldValue.arrayUnion([userId]),
    });

    await _firestore.collection('users').doc(userId).update({
      'roomId': roomCode,
    });
  }

  Future<void> addItemToRoom(String roomId, ChecklistItem item) async {
    await _firestore
        .collection('rooms')
        .doc(roomId)
        .collection('items')
        .add(item.toMap());
  }

  Future<RoomModel?> getRoomById(String roomId) async {
    try {
      final doc = await _firestore.collection('rooms').doc(roomId).get();
      if (!doc.exists) return null;
      return RoomModel.fromJson(doc.data()!, doc.id);
    } catch (e) {
      print('getRoomById error: $e');
      return null;
    }
  }

  Future<void> updateRoom(String roomId, Map<String, dynamic> data) async {
    await _firestore.collection('rooms').doc(roomId).update(data);
  }

  Future<void> removeUserFromRoom(String roomId, String userId) async {
    await _firestore.collection('rooms').doc(roomId).update({
      'participants': FieldValue.arrayRemove([userId])
    });
  }

  Future<void> deleteRoom(String roomId) async {
    await _firestore.collection('rooms').doc(roomId).delete();
  }

  // 🔹 Senkronizasyon için yeni item ekler ve doc.id döner
  Future<String> addItem(String roomId, ChecklistItem item) async {
    final docRef = await _firestore
        .collection('rooms')
        .doc(roomId)
        .collection('items')
        .add(item.toMap());

    return docRef.id;
  }

// 🔹 Mevcut item'ı günceller
  Future<void> updateItem(String roomId, ChecklistItem item) async {
    if (item.id.isEmpty) {
      throw Exception("Güncellenecek item'ın id'si boş olamaz.");
    }

    await _firestore
        .collection('rooms')
        .doc(roomId)
        .collection('items')
        .doc(item.id)
        .update(item.toMap());
  }
}
