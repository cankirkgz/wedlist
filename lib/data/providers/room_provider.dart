import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wedlist/features/room/model/room_model.dart';
import 'package:wedlist/features/room/viewmodel/room_view_model.dart';

final roomProvider = StateNotifierProvider<RoomViewModel, RoomState>(
  (ref) => RoomViewModel(),
);

final roomFutureProvider = FutureProvider<RoomModel?>((ref) async {
  final roomVM = ref.read(roomProvider.notifier);
  return await roomVM.getCurrentUserRoom();
});
