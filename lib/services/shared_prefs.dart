import 'package:doomi/interfaces/local_storage.dart';
import 'package:doomi/interfaces/themes.dart';
import 'package:doomi/utils/Themes/dark_theme.dart';
import 'package:doomi/utils/Themes/light_theme.dart';
import 'package:doomi/utils/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs extends ILocalStorage {
  static SharedPreferences? _prefs;

  @override
  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  DoomiLocale? getLocale() {
    String? value = _prefs!.getString('locale_v1');
    if (value == null) return null;
    if (value == DoomiLocale.arabic.name) return DoomiLocale.arabic;
    return DoomiLocale.english;
  }

  @override
  void saveLocale(DoomiLocale locale) {
    _prefs!.setString('locale_v1', locale.name);
  }

  @override
  ITheme? getTheme() {
    String? value = _prefs!.getString('theme_v1');
    if (value == null) return null;
    if (value == LightTheme().name) return LightTheme();
    return DarkTheme();
  }

  @override
  void saveTheme(ITheme theme) {
    _prefs!.setString('theme_v1', theme.name);
  }
}
