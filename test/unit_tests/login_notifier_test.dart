import 'package:doomi/models/database%20models/user.dart' as model;
import 'package:doomi/providers/login_screen_notifier.dart';
import 'package:doomi/utils/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mock_objects.dart/app_initialization_test.mocks.dart';
import '../mock_objects.dart/register_notifier_test.mocks.dart';

void main() {
  group('LoginScreenNotifier', () {
    late MockIAuthService authService;
    late MockUserNotifier userNotifier;
    late MockIOnlineStorage onlineStorage;
    late LoginScreenNotifier loginScreenNotifier;

    setUp(() {
      authService = MockIAuthService();
      userNotifier = MockUserNotifier();
      onlineStorage = MockIOnlineStorage();
      loginScreenNotifier = LoginScreenNotifier(
        authService: authService,
        userNotifier: userNotifier,
        db: onlineStorage,
      );
    });

    test(
        'areInfofilled should return true when email and password are not empty',
        () {
      loginScreenNotifier.setEmail = 't';
      loginScreenNotifier.setPassword = 'password';
      expect(loginScreenNotifier.areInfofilled(), true);
    });

    test(
        'areInfofilled should return false when either email or password is empty',
        () {
      loginScreenNotifier.setEmail = 'test@example.com';
      expect(loginScreenNotifier.areInfofilled(), false);
      loginScreenNotifier.setEmail = '';
      loginScreenNotifier.setPassword = 'password';
      expect(loginScreenNotifier.areInfofilled(), false);
    });

    test('onLoginPressed should sign in user and set user in UserNotifier',
        () async {
      final mockSavedUser = model.User(
        id: '123',
        firstName: 'John',
        lastName: 'Doe',
        email: 'test@example.com',
      );

      when(authService.signIn(any, any)).thenAnswer((_) async => '123');
      when(onlineStorage.getUser('123')).thenAnswer((_) async => mockSavedUser);

      await loginScreenNotifier.onLoginPressed();

      verify(authService.signIn(any, any)).called(1);
      verify(onlineStorage.getUser('123')).called(1);
      verify(userNotifier.user = any).called(1);
    });

    test('onLoginPressed should throw InvalidEmailException for invalid email',
        () async {
      when(authService.signIn(any, any))
          .thenThrow(FirebaseAuthException(code: 'invalid-email'));

      expect(() => loginScreenNotifier.onLoginPressed(),
          throwsA(isInstanceOf<InvalidEmailException>()));
    });

    // test('onLoginPressed should throw UserNotFound for disabled or non-existing user', () async {
    //   when(authService.signIn(any, any)).thenThrow(FirebaseAuthException(code: 'user-disabled'));
    //   expect(() => loginScreenNotifier.onLoginPressed(), throwsA(isInstanceOf<UserNotFound>()));

    //   when(authService.signIn(any, any)).thenThrow(FirebaseAuthException(code:
  });
}
