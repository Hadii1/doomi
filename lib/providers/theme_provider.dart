import 'package:doomi/interfaces/local_storage.dart';
import 'package:doomi/interfaces/themes.dart';
import 'package:doomi/providers/local_stoage_provider.dart';
import 'package:doomi/utils/Themes/light_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ITheme>(
  (ref) => ThemeNotifier(
    ref.watch(localStorageProvider),
  ),
);

class ThemeNotifier extends StateNotifier<ITheme> {
  final ILocalStorage _storage;

  ThemeNotifier(this._storage) : super(_storage.getTheme() ?? LightTheme()) {
    _initState();
  }

  _initState() {
    ITheme? savedTheme = _storage.getTheme();
    if (savedTheme == null) {
      setTheme(LightTheme());
    } else {
      setTheme(savedTheme);
    }
  }

  void setTheme(ITheme theme) {
    if (_storage.getTheme() != theme) {
      _storage.saveTheme(theme);
    }

    if (state != theme) {
      state = theme;
    }
  }
}
