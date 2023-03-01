import 'package:doomi/providers/register_screen_notifier.dart';
import 'package:doomi/providers/user_provider.dart';
import 'package:doomi/utils/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import '../mock_objects.dart/app_initialization_test.mocks.dart';
import '../mock_objects.dart/register_notifier_test.mocks.dart';

@GenerateNiceMocks([MockSpec<UserNotifier>()])
void main() {
  group('RegisterScreenNotifier', () {
    late MockIAuthService authService;
    late MockUserNotifier userNotifier;
    late MockIOnlineStorage onlineStorage;
    late RegisterScreenNotifier registerScreenNotifier;

    setUp(() {
      authService = MockIAuthService();
      userNotifier = MockUserNotifier();
      onlineStorage = MockIOnlineStorage();
      registerScreenNotifier = RegisterScreenNotifier(
        authService: authService,
        userNotifier: userNotifier,
        db: onlineStorage,
      );
    });

    test('should return true if all fields are filled', () {
      registerScreenNotifier.setEmail = 'test@example.com';
      registerScreenNotifier.setFirstName = 'John';
      registerScreenNotifier.setLastName = 'Doe';
      registerScreenNotifier.setPassword = 'password';
      registerScreenNotifier.setPasswordConfirmation = 'password';
      expect(registerScreenNotifier.areInfofilled(), true);
    });

    test('should return false if any field is empty', () {
      registerScreenNotifier.setEmail = 'test@example.com';
      registerScreenNotifier.setFirstName = 'John';
      registerScreenNotifier.setLastName = 'Doe';
      registerScreenNotifier.setPassword = 'password';
      registerScreenNotifier.setPasswordConfirmation = '';
      expect(registerScreenNotifier.areInfofilled(), false);
    });

    test('should throw PasswordsNotMatchingException if passwords do not match',
        () {
      registerScreenNotifier.setEmail = 'test@example.com';
      registerScreenNotifier.setFirstName = 'John';
      registerScreenNotifier.setLastName = 'Doe';
      registerScreenNotifier.setPassword = 'password';
      registerScreenNotifier.setPasswordConfirmation = 'not matching password';
      expect(() => registerScreenNotifier.onRegisterPressed(),
          throwsA(isInstanceOf<PasswordsNotMatchingException>()));
    });

    // test('should save user to database and set userNotifier.user', () async {
  });
}
