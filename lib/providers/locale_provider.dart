import 'package:doomi/interfaces/local_storage.dart';
import 'package:doomi/providers/default_device_locale_provider.dart';
import 'package:doomi/providers/local_stoage_provider.dart';
import 'package:doomi/utils/enums.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localProvider = StateNotifierProvider<LocalNotifier, DoomiLocale>(
  (ref) => LocalNotifier(
    ref.watch(localStorageProvider),
    ref.read(defaultDeviceLocaleProvider),
  ),
);

class LocalNotifier extends StateNotifier<DoomiLocale> {
  final ILocalStorage _storage;
  final DoomiLocale _defaultDeviceLocale;

  LocalNotifier(
    this._storage,
    this._defaultDeviceLocale,
  ) : super(
          _storage.getLocale() ?? _defaultDeviceLocale,
        );

  // List<Locale> supportedLocales

  init() {
    DoomiLocale? savedLocale = _storage.getLocale();
    if (savedLocale == null) {
      setLocal(_defaultDeviceLocale);
    } else {
      setLocal(savedLocale);
    }
  }

  void setLocal(DoomiLocale locale) {
    if (_storage.getLocale() != locale) {
      _storage.saveLocale(locale);
    }
    if (state != locale) {
      state = locale;
    }
  }
}
