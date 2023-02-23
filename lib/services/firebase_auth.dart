import 'package:doomi/interfaces/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService implements IAuthService {
  static final _auth = FirebaseAuth.instance;
  @override
  String? userId() {
    return _auth.currentUser?.uid;
  }

  @override
  Future<User> registerUser(String email, String password) async {
    UserCredential credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user!;
  }

  @override
  Future<User> signIn(String email, String password) async {
    UserCredential credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return credential.user!;
  }
}
