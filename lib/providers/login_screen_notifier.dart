import 'package:doomi/interfaces/auth.dart';
import 'package:doomi/interfaces/online_storage.dart';
import 'package:doomi/models/database%20models/user.dart' as model;
import 'package:doomi/providers/auth_service_provider.dart';
import 'package:doomi/providers/online_storage_provider.dart';
import 'package:doomi/providers/user_provider.dart';
import 'package:doomi/utils/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginScreenNotifier = ChangeNotifierProvider.autoDispose(
  (ref) => LoginScreenNotifier(
    db: ref.watch(onlineStorageProvider),
    authService: ref.watch(authServiceProvider),
    userNotifier: ref.watch(userProvider.notifier),
  ),
);

class LoginScreenNotifier extends ChangeNotifier {
  final IAuthService authService;
  final UserNotifier userNotifier;
  final IOnlineStorage db;

  LoginScreenNotifier({
    required this.authService,
    required this.db,
    required this.userNotifier,
  });

  @visibleForTesting
  String email = '';
  @visibleForTesting
  String password = '';

  set setEmail(String e) {
    email = e;
    notifyListeners();
  }

  set setPassword(String p) {
    password = p;
    notifyListeners();
  }

  bool areInfofilled() => email.isNotEmpty && password.isNotEmpty;

  onLoginPressed() async {
    try {
      String user = await authService.signIn(email, password);
      model.User? savedUser = await db.getUser(user);
      userNotifier.user = model.User(
        id: user,
        firstName: savedUser!.firstName,
        lastName: savedUser.lastName,
        email: savedUser.email,
      );
    } on Exception catch (e, _) {
      if (e is FirebaseAuthException) {
        if (e.code == 'invalid-email') {
          throw InvalidEmailException();
        } else if (e.code == 'user-disabled' || e.code == 'user-not-found') {
          throw UserNotFound();
        } else if (e.code == 'wrong-password') {
          throw WrongPasswordException();
        }
      }
    }
  }
}
