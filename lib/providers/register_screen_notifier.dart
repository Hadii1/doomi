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

final registerScreenNotifier = ChangeNotifierProvider.autoDispose(
  (ref) => RegisterScreenNotifier(
    db: ref.watch(onlineStorageProvider),
    authService: ref.watch(authServiceProvider),
    userNotifier: ref.watch(userProvider.notifier),
  ),
);

class RegisterScreenNotifier extends ChangeNotifier {
  final IAuthService authService;
  final UserNotifier userNotifier;
  final IOnlineStorage db;

  RegisterScreenNotifier({
    required this.authService,
    required this.db,
    required this.userNotifier,
  });

  @visibleForTesting
  String email = '';
  @visibleForTesting
  String firstName = '';
  @visibleForTesting
  String lastName = '';
  @visibleForTesting
  String password = '';
  @visibleForTesting
  String passwordConfirmation = '';

  set setEmail(String e) {
    email = e;
    notifyListeners();
  }

  set setFirstName(String v) {
    firstName = v;
    notifyListeners();
  }

  set setLastName(String v) {
    lastName = v;
    notifyListeners();
  }

  set setPassword(String p) {
    password = p;
    notifyListeners();
  }

  set setPasswordConfirmation(String e) {
    passwordConfirmation = e;
    notifyListeners();
  }

  bool areInfofilled() =>
      email.isNotEmpty &&
      password.isNotEmpty &&
      passwordConfirmation.isNotEmpty &&
      firstName.isNotEmpty &&
      lastName.isNotEmpty;

  onRegisterPressed() async {
    if (passwordConfirmation != password) {
      throw PasswordsNotMatchingException();
    }

    try {
      String user = await authService.registerUser(email, password);

      model.User onlineUser = model.User(
        id: user,
        firstName: firstName,
        lastName: lastName,
        email: email,
      );

      await db.saveUser(onlineUser);

      userNotifier.user = onlineUser;
    } on Exception catch (e, _) {
      if (e is FirebaseAuthException) {
        if (e.code == 'invalid-email') {
          throw InvalidEmailException();
        } else if (e.code == 'weak-password') {
          throw WeakPasswordException();
        } else if (e.code == 'email-already-in-use') {
          throw EmailAlreadyInUseException();
        }
      }
    }
  }
}
