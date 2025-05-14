import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wedlist/data/services/local_item_service.dart';

final localItemServiceProvider = Provider<LocalItemService>((ref) {
  return LocalItemService();
});
