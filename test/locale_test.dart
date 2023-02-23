// ignore_for_file: invalid_use_of_protected_member

import 'package:doomi/interfaces/local_storage.dart';
import 'package:doomi/providers/locale_provider.dart';
import 'package:doomi/utils/enums.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'locale_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ILocalStorage>()])
void main() {
  group('Locale Notifier', () {
    late MockILocalStorage localStorage;
    setUp(() => localStorage = MockILocalStorage());
    test('initial state is set correctly', () {
      when(localStorage.getLocale()).thenReturn(DoomiLocale.arabic);

      LocalNotifier localNotifier =
          LocalNotifier(localStorage, DoomiLocale.english);

      final state = localNotifier.state;
      expect(state, DoomiLocale.arabic);
    });

    test('default locale is used correctly if no locale is previously saved',
        () {
      when(localStorage.getLocale()).thenReturn(null);
      LocalNotifier localNotifier =
          LocalNotifier(localStorage, DoomiLocale.arabic);

      verify(localStorage.saveLocale(DoomiLocale.arabic)).called(1);
      expect(localNotifier.state, DoomiLocale.arabic);
    });

    test('setLocal updates the state and saves to local storage', () {
      LocalNotifier localNotifier =
          LocalNotifier(localStorage, DoomiLocale.english);

      localNotifier.setLocal(DoomiLocale.arabic);

      verify(localStorage.saveLocale(DoomiLocale.arabic)).called(1);
      expect(localNotifier.state, DoomiLocale.arabic);

      localNotifier.setLocal(DoomiLocale.english);

      verify(localStorage.saveLocale(DoomiLocale.english)).called(2);
      expect(localNotifier.state, DoomiLocale.english);
    });
  });
}
