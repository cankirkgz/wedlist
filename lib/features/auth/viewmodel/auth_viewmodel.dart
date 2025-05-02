import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wedlist/app/router.dart';
import 'package:wedlist/data/services/auth_service.dart';
import 'package:wedlist/data/services/firestore_service.dart';
import 'package:wedlist/features/auth/model/user_model.dart';
import 'package:auto_route/auto_route.dart';

class AuthState {
  final UserModel? user;
  final bool isLoading;
  final String? error;

  AuthState({
    this.user,
    this.isLoading = false,
    this.error,
  });

  AuthState copyWith({
    UserModel? user,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();

  AuthViewModel() : super(AuthState());

  Future<UserModel?> signIn(
      String email, String password, BuildContext context) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final credential =
          await _authService.signInWithEmail(email: email, password: password);
      final userId = credential.user!.uid;
      final userModel = await _firestoreService.getUser(userId);

      if (userModel != null) {
        state = state.copyWith(user: userModel, isLoading: false);
        await handlePostLoginRouting(context);
        return userModel;
      } else {
        throw FirebaseAuthException(
            code: 'not-found', message: 'Kullanıcı verisi bulunamadı');
      }
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
      return null;
    }
  }

  Future<UserModel?> signUp(
      String email, String password, String name, BuildContext context) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final credential =
          await _authService.signUpWithEmail(email: email, password: password);
      final userId = credential.user!.uid;
      final userModel = UserModel(
        email: email,
        name: name,
        createdAt: DateTime.now(),
        roomId: null,
      );
      await _firestoreService.createUser(userId: userId, user: userModel);
      state = state.copyWith(user: userModel, isLoading: false);
      await handlePostLoginRouting(context);
      return userModel;
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
      return null;
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    state = AuthState();
  }

  Future<void> resetPassword(String email) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _authService.sendPasswordResetEmail(email);
      state = state.copyWith(isLoading: false);
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    }
  }

  Future<void> handlePostLoginRouting(BuildContext context) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    final user = await _firestoreService.getUser(userId);
    if (user == null) return;

    if (user.roomId == null || user.roomId!.isEmpty) {
      context.router.replace(const WelcomeRoute());
      print("Welcome'a gidildi");
    } else {
      context.router.replace(ChecklistRoute(roomId: user.roomId!));
      print("Checklist'e gidildi");
    }
  }
}
