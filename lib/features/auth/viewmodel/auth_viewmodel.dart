import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wedlist/data/services/auth_service.dart';
import 'package:wedlist/features/auth/model/user_model.dart';

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

  AuthViewModel() : super(AuthState());

  Future<UserModel?> signIn(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final credential =
          await _authService.signInWithEmail(email: email, password: password);
      final user = credential.user;

      final userModel = UserModel(
        email: user?.email ?? '',
        name: user?.displayName ?? '',
        createdAt: user?.metadata.creationTime ?? DateTime.now(),
      );

      state = state.copyWith(user: userModel, isLoading: false);
      return userModel;
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
      return null;
    }
  }

  Future<UserModel?> signUp(String email, String password, String name) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final credential = await _authService.signUpWithEmail(
        email: email,
        password: password,
      );

      final userModel = UserModel(
        email: email,
        name: name,
        createdAt: DateTime.now(),
      );

      state = state.copyWith(user: userModel, isLoading: false);
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
}
