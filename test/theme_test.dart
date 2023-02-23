// ignore_for_file: invalid_use_of_protected_member

import 'package:doomi/interfaces/local_storage.dart';
import 'package:doomi/providers/theme_provider.dart';
import 'package:doomi/utils/Themes/dark_theme.dart';
import 'package:doomi/utils/Themes/light_theme.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'theme_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ILocalStorage>()])
void main() {
  group('Theme Notifier', () {
    late MockILocalStorage localStorage;
    setUp(() => localStorage = MockILocalStorage());
    test(
      'Initial theme is set up correctly if none is saved',
      () {
        when(localStorage.getTheme()).thenReturn(null);

        ThemeNotifier themeNotifier = ThemeNotifier(localStorage);

        verify(localStorage.saveTheme(LightTheme())).called(1);
        final state = themeNotifier.state;
        expect(state.name, LightTheme().name);
      },
    );

    test(
      'setTheme updates the state and saves to local storage',
      () {
        ThemeNotifier themeNotifier = ThemeNotifier(localStorage);

        themeNotifier.setTheme(DarkTheme());

        // verify(localStorage.saveTheme(LightTheme())).called(1);
        verify(localStorage.saveTheme(DarkTheme())).called(1);

        final state = themeNotifier.state;
        expect(state.name, DarkTheme().name);
      },
    );
  });
}
