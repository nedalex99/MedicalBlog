import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static Future<AuthService> get _instance async =>
      _authService ??= AuthService();
  static AuthService _authService;

  static Future<AuthService> init() async {
    if (_authService == null) _authService = await _instance;
    return _authService;
  }

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> createUserWithEmailAndPassword(
      {String email, String password}) {
    return _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserCredential> signInWithEmailAndPassword(
      {String email, String password}) {
    return _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  User getUser() {
    return _firebaseAuth.currentUser;
  }
}
