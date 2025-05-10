import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wedlist/app/router.dart';
import 'package:wedlist/data/services/firestore_service.dart';
import 'package:wedlist/features/auth/model/user_model.dart';
import 'package:wedlist/features/room/model/room_model.dart';
import 'package:wedlist/features/room/service/room_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// ✅ Provider tanımı
final roomProvider = AsyncNotifierProvider<RoomViewModel, RoomModel?>(
  RoomViewModel.new,
);

/// ✅ AsyncNotifier kullanımıyla ViewModel
class RoomViewModel extends AsyncNotifier<RoomModel?> {
  final _firestore = FirestoreService();

  /// 📌 build metodu: kullanıcıya ait odayı getirir
  @override
  Future<RoomModel?> build() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    final userDoc = await _firestore.getUser(user.uid);
    final roomId = userDoc?.roomId;
    if (roomId == null || roomId.isEmpty) return null;

    return await _firestore.getRoomById(roomId);
  }

  /// ✅ Yeni oda oluştur
  Future<String?> createRoom(BuildContext context) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser!;
      final roomCode = RoomService.generateRoomCode();
      final roomData = RoomModel(
        id: '',
        roomName: AppLocalizations.of(context)!.defaultRoomName,
        createdBy: currentUser.uid,
        createdAt: DateTime.now(),
        participants: [currentUser.uid],
        totalItems: 0,
        completedItems: 0,
      );
      final docRef = await _firestore.createRoom(roomData, roomCode);
      await _firestore
          .updateUser(userId: currentUser.uid, data: {'roomId': docRef.id});
      state = AsyncValue.data(await _firestore.getRoomById(docRef.id));
      return docRef.id;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return null;
    }
  }

  /// ✅ Var olan odaya katıl
  Future<bool> joinRoom(String roomCode, BuildContext context) async {
    final roomSnapshot = await _firestore.getRoomByCode(roomCode);
    if (roomSnapshot == null) return false;

    final roomId = roomSnapshot.id;
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return false;

    await _firestore.addUserToRoom(roomId, currentUser.uid);
    await _firestore.updateUser(
      userId: currentUser.uid,
      data: {'roomId': roomId},
    );

    // 📌 State güncelle
    state = AsyncValue.data(await _firestore.getRoomById(roomId));

    context.router.replaceAll([ChecklistRoute(roomId: roomId)]);
    return true;
  }

  /// ✅ Oda adını güncelle
  Future<void> updateRoomName(String roomId, String newName) async {
    await _firestore.updateRoom(roomId, {'roomName': newName});
    state = AsyncValue.data(await _firestore.getRoomById(roomId));
  }

  /// ✅ Baş harfleri hesapla
  String getInitialsFromName(String name) {
    final parts = name.trim().split(' ');
    final initials =
        parts.map((e) => e.isNotEmpty ? e[0].toUpperCase() : '').join();
    return initials.length > 2 ? initials.substring(0, 2) : initials;
  }

  /// ✅ Katılımcı bilgilerini hazırla
  List<Map<String, String>> mapUsersToParticipantInfo(List<UserModel> users) {
    final currentEmail = FirebaseAuth.instance.currentUser?.email;

    return users.map((user) {
      final initials = getInitialsFromName(user.name);
      final role = user.email == currentEmail ? "you" : "";
      return {
        'initials': initials,
        'name': user.name,
        'role': role,
      };
    }).toList();
  }

  Future<void> leaveRoom(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    final room = state.value;
    if (user == null || room == null) return;

    // Firestore'dan kullanıcıyı odadan çıkar
    await _firestore.updateUser(
      userId: user.uid,
      data: {'roomId': null},
    );
    await _firestore.removeUserFromRoom(room.id, user.uid);

    state = const AsyncValue.data(null); // local state temizle
    context.router.replaceAll([const WelcomeRoute()]);
  }

  Future<void> deleteRoom(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    final room = state.value;
    if (user == null || room == null) return;

    // Odayı tamamen sil
    await _firestore.deleteRoom(room.id);

    // Kullanıcının roomId bilgisini sıfırla
    await _firestore.updateUser(userId: user.uid, data: {'roomId': null});

    state = const AsyncValue.data(null);
    context.router.replaceAll([const WelcomeRoute()]);
  }
}
