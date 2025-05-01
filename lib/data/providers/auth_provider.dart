import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wedlist/features/auth/viewmodel/auth_viewmodel.dart';

final authProvider = StateNotifierProvider<AuthViewModel, AuthState>(
  (ref) => AuthViewModel(),
);
