import 'dart:io';
import 'package:doomi/utils/enums.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final defaultDeviceLocaleProvider = Provider<DoomiLocale>(
  (ref) {
    String deviceLocale = Platform.localeName;
    if (deviceLocale.toLowerCase().split('_').first == 'ar') {
      return DoomiLocale.arabic;
    } else {
      return DoomiLocale.english;
    }
  },
);
