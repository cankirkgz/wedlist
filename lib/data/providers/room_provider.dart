import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wedlist/data/services/firestore_service.dart';
import 'package:wedlist/features/auth/model/user_model.dart';
import 'package:wedlist/features/room/model/room_model.dart';
import 'package:wedlist/features/room/viewmodel/room_view_model.dart';

/// ✅ Odadaki tüm bilgileri tutan ana provider
final roomProvider = AsyncNotifierProvider<RoomViewModel, RoomModel?>(
  RoomViewModel.new,
);

/// ✅ Odadaki katılımcıları getiren provider
final participantsProvider = FutureProvider<List<UserModel>>((ref) async {
  final roomAsync = await ref
      .watch(roomProvider.future); // 👈 artık direkt roomProvider.future
  final firestore = FirestoreService();

  if (roomAsync == null || roomAsync.participants.isEmpty) {
    print("Room is null or participants list is empty");
    return [];
  }

  print("Fetching participants: ${roomAsync.participants}");

  final futures = roomAsync.participants.map(firestore.getUser).toList();
  final resolved = await Future.wait(futures);

  final users = resolved.whereType<UserModel>().toList();
  print("Fetched ${users.length} participants");

  return users;
});
