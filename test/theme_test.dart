// ignore_for_file: invalid_use_of_protected_member

import 'package:doomi/interfaces/local_storage.dart';
import 'package:doomi/providers/theme_provider.dart';
import 'package:doomi/utils/Themes/dark_theme.dart';
import 'package:doomi/utils/Themes/light_theme.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockLocalStorage extends Mock implements ILocalStorage {}

void main() {
  group('themeNotifier', () {
    test(
      'Initial theme is set up correctly if none is saved',
      () {
        MockLocalStorage localStorage = MockLocalStorage();
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
        MockLocalStorage localStorage = MockLocalStorage();
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
