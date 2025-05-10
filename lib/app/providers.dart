import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:wedlist/features/checklist/model/checklist_item_model.dart';
import 'package:wedlist/features/checklist/viewmodel/checklist_viewmodel.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

/// ✅ Async ViewModel Provider (doğru tip)
final checklistProvider =
    AutoDisposeAsyncNotifierProvider<ChecklistViewModel, List<ChecklistItem>>(
  ChecklistViewModel.new,
);

final currentRoomCodeProvider = StateProvider<String>((ref) => '');
final isLoadingProvider = StateProvider<bool>((ref) => false);
