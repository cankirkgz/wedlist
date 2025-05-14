import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wedlist/data/providers/firestore_service_provider.dart';
import 'package:wedlist/data/providers/local_item_service_provider.dart';
import 'package:wedlist/data/services/sync_service.dart';

final syncServiceProvider = Provider<SyncService>((ref) {
  final local = ref.read(localItemServiceProvider);
  final firestore = ref.read(firestoreServiceProvider);
  return SyncService(local, firestore);
});
