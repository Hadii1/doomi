import 'package:doomi/interfaces/auth.dart';
import 'package:doomi/interfaces/local_storage.dart';
import 'package:doomi/interfaces/online_storage.dart';
import 'package:doomi/models/database%20models/user.dart';
import 'package:doomi/providers/auth_service_provider.dart';
import 'package:doomi/providers/initialization_provider.dart';
import 'package:doomi/providers/local_stoage_provider.dart';
import 'package:doomi/providers/online_storage_provider.dart';
import 'package:doomi/providers/user_provider.dart';
import 'package:doomi/utils/enums.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import '../mock_objects.dart/app_initialization_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<IAuthService>(),
  MockSpec<IOnlineStorage>(),
  MockSpec<ILocalStorage>()
])
void main() {
  group('Initialization Provider', () {
    late MockIAuthService authService;
    late MockIOnlineStorage onlineStorage;
    late MockILocalStorage localStorage;
    late ProviderContainer container;

    setUp(() {
      authService = MockIAuthService();
      onlineStorage = MockIOnlineStorage();
      localStorage = MockILocalStorage();
      container = ProviderContainer(
        overrides: [
          onlineStorageProvider.overrideWithValue(onlineStorage),
          localStorageProvider.overrideWithValue(localStorage),
          authServiceProvider.overrideWithValue(authService),
        ],
      );
    });

    test('User is new', () async {
      when(authService.userId()).thenReturn(null);

      final a = await appInitializationProvider.future.read(container);

      expect(a, AppInitializationState.loggedOut);
    });

    test('User logged in', () async {
      when(authService.userId()).thenReturn('123');
      when(onlineStorage.getUser('123')).thenAnswer(
        (inv) async => User(
          id: '123',
          firstName: '',
          lastName: '',
          email: '',
        ),
      );

      final a = await appInitializationProvider.future.read(container);
      verify(onlineStorage.getUser('123')).called(1);
      expect(userProvider.notifier.read(container).state!.id, '123');
      expect(a, AppInitializationState.loggedIn);
    });
  });
}
