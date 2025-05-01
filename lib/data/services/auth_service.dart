import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 🔐 Kayıt Ol
  Future<UserCredential> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await credential.user?.sendEmailVerification(); // Doğrulama maili gönder

    return credential;
  }

  // 🔑 Giriş Yap
  Future<UserCredential> signInWithEmail({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // 📩 E-posta Doğrulama Gönder
  Future<void> sendEmailVerification() async {
    final user = _auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  // 🔁 Şifre Sıfırlama
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  // 🚪 Çıkış Yap
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // 👤 Kullanıcıyı getir
  User? get currentUser => _auth.currentUser;

  // 📡 Kullanıcı oturum dinleyicisi
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
