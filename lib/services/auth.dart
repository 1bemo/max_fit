import 'package:firebase_auth/firebase_auth.dart';
import 'package:max_fit/domain/authUser.dart';

class AuthService {
  final FirebaseAuth _fAuth = FirebaseAuth.instance;

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _fAuth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      User? user = result.user;
      return AuthUser.fromFirebase(user);
    } catch (e) {
      return null;
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _fAuth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      User? user = result.user;
      return AuthUser.fromFirebase(user);
    } catch (e) {
      return null;
    }
  }

  Future logOut() async {
    await _fAuth.signOut();
  }

  Stream<AuthUser?> get currentUser {
    return _fAuth.authStateChanges()
        .map((user) => user != null ? AuthUser.fromFirebase(user) : null);
  }

}