import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:wedlist/features/checklist/model/checklist_item_model.dart';
import 'package:wedlist/features/checklist/viewmodel/checklist_viewmodel.dart';

/// Firebase servislerini sağlayan global provider'lar
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

/// Checklist ViewModel Provider
final checklistViewModelProvider =
    NotifierProvider<ChecklistViewModel, List<ChecklistItem>>(() {
  return ChecklistViewModel();
});

/// Örnek: Room kodunu tutan provider (gerekirse ayrı ayrı kullanırsın)
final currentRoomCodeProvider = StateProvider<String>((ref) => '');

/// Örnek: Kullanıcının loading state'ini takip eden provider
final isLoadingProvider = StateProvider<bool>((ref) => false);

/// TODO: Diğer feature'lara ait viewmodel/provider'lar buraya eklenecek
/// Örn: authViewModelProvider, settingsViewModelProvider vs.
