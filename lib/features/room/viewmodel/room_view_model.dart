import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wedlist/app/router.dart';
import 'package:wedlist/data/services/firestore_service.dart';
import 'package:wedlist/features/room/model/room_model.dart';
import 'package:wedlist/features/room/service/room_service.dart';

class RoomState {}

class RoomViewModel extends StateNotifier<RoomState> {
  final FirestoreService _firestore = FirestoreService();

  RoomViewModel() : super(RoomState());

  Future<String?> createRoom() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return null;

    final roomCode = RoomService.generateRoomCode();

    final room = RoomModel(
      id: '', // Firestore tarafından verilecek
      roomName: 'Düğün Hazırlık Listemiz',
      createdBy: currentUser.uid,
      createdAt: DateTime.now(),
      participants: [currentUser.uid],
      totalItems: 0,
      completedItems: 0,
    );

    // Odayı Firestore'a kaydet
    final docRef = await _firestore.createRoom(room, roomCode);

    // Kullanıcıya bu roomId'yi kaydet
    await _firestore.updateUser(
      userId: currentUser.uid,
      data: {'roomId': docRef.id},
    );

    return docRef.id;
  }

  Future<bool> joinRoom(String roomCode, BuildContext context) async {
    final roomSnapshot = await _firestore.getRoomByCode(roomCode);
    if (roomSnapshot == null) {
      return false;
    }

    final roomId = roomSnapshot.id;
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return false;

    // Kullanıcıyı odaya dahil et (listeye ekle)
    await _firestore.addUserToRoom(roomId, currentUser.uid);

    // Kullanıcının Firestore'daki roomId'sini güncelle
    await _firestore
        .updateUser(userId: currentUser.uid, data: {'roomId': roomId});

    // Yönlendirme
    context.router.replaceAll([ChecklistRoute(roomId: roomId)]);

    return true;
  }
}
