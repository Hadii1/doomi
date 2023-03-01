abstract class IAuthService {
  String? userId();

  Future<String> registerUser(String email, String password);

  Future<String> signIn(String email, String password);

  Future<void> signOut();
}
