import 'package:doomi/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String getReadableDate(DoomiLocale locale) {
    String localeName;
    switch (locale) {
      case DoomiLocale.english:
        localeName = 'en';
        break;
      case DoomiLocale.arabic:
        localeName = 'ar';
        break;
    }

    return DateFormat.yMd(localeName).format(this);
  }
}

extension LocalesExtension on DoomiLocale {
  Locale get getOfficialLocal {
    switch (this) {
      case DoomiLocale.english:
        return const Locale('en');

      case DoomiLocale.arabic:
        return const Locale('ar');
    }
  }
}
