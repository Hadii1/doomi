import 'package:doomi/utils/enums.dart';

abstract class ILocalStorage {
  void saveLocale(DoomiLocale locale);

  DoomiLocale? getLocale();
}
