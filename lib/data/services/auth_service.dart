import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

    await credential.user?.sendEmailVerification();

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

  // 🔁 🔒 GOOGLE İLE GİRİŞ
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null; // Kullanıcı işlemi iptal etti

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _auth.signInWithCredential(credential);
    } catch (e) {
      print('Google ile giriş hatası: $e');
      return null;
    }
  }
}
