import 'package:doomi/interfaces/local_storage.dart';
import 'package:doomi/utils/enums.dart';

class LocalStorage extends ILocalStorage {
  @override
  DoomiLocale? getLocale() {
    throw UnimplementedError();
  }

  @override
  void saveLocale(DoomiLocale locale) {}
}
