import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthService {
  String? userId();

  Future<User> registerUser(String email, String password);

  Future<User> signIn(String email, String password);
}
