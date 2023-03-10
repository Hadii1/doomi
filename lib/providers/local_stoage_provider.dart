import 'package:doomi/interfaces/local_storage.dart';
import 'package:doomi/services/shared_prefs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageProvider = Provider<ILocalStorage>((ref) {
  return SharedPrefs();
});
