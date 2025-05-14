import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wedlist/data/services/firestore_service.dart';

final firestoreServiceProvider = Provider<FirestoreService>((ref) {
  return FirestoreService();
});
