import 'package:doomi/interfaces/local_storage.dart';
import 'package:doomi/interfaces/themes.dart';
import 'package:doomi/utils/enums.dart';

class SharedPrefs extends ILocalStorage {
  @override
  DoomiLocale? getLocale() {
    throw UnimplementedError();
  }

  @override
  void saveLocale(DoomiLocale locale) {
    throw UnimplementedError();
  }

  @override
  ITheme? getTheme() {
    throw UnimplementedError();
  }

  @override
  void saveTheme(ITheme theme) {
    throw UnimplementedError();
  }

  @override
  Future<void> initialize() {
    throw UnimplementedError();
  }
}
