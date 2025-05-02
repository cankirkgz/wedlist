import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wedlist/features/room/viewmodel/room_view_model.dart';

final roomProvider = StateNotifierProvider<RoomViewModel, RoomState>(
  (ref) => RoomViewModel(),
);
