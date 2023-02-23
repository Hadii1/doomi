import 'package:doomi/interfaces/themes.dart';
import 'package:doomi/utils/enums.dart';

abstract class ILocalStorage {
  Future<void> initialize();

  void saveLocale(DoomiLocale locale);

  DoomiLocale? getLocale();

  void saveTheme(ITheme theme);

  ITheme? getTheme();
}
