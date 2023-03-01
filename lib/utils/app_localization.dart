// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DoomiLocalizations {
  DoomiLocalizations(this.locale);

  final Locale locale;

  static DoomiLocalizations of(BuildContext context) {
    return Localizations.of<DoomiLocalizations>(context, DoomiLocalizations)!;
  }

  static const DoomiLocalizationsDelegate delegate =
      DoomiLocalizationsDelegate();

  late final Map<String, String> _localizedValues;
  static final List<String> languages = ['en', 'ar'];

  Future<void> loadTest() async {
    _localizedValues = {};
  }

  Future<void> load() async {
    /// Get the langauge data, decode it and cast it to the [_localizedValues].
    String s =
        await rootBundle.loadString('assets/i18n/${locale.languageCode}.json');
    Map<String, dynamic> m = json.decode(s);
    _localizedValues = m.map((key, value) => MapEntry(key, value.toString()));
  }

  String translate(String key) {
    String? translation = _localizedValues[key];
    if (translation == null) {
      return key;
    }
    return translation;
  }
}

class DoomiLocalizationsDelegate
    extends LocalizationsDelegate<DoomiLocalizations> {
  const DoomiLocalizationsDelegate({this.isInTestingMode = false});

  final bool isInTestingMode;

  @override
  bool isSupported(Locale locale) =>
      DoomiLocalizations.languages.contains(locale.languageCode);

  @override
  Future<DoomiLocalizations> load(Locale locale) async {
    DoomiLocalizations convivioLocalizations = DoomiLocalizations(locale);

    if (isInTestingMode) {
      await convivioLocalizations.loadTest();
      return convivioLocalizations;
    } else {
      await convivioLocalizations.load();
      return convivioLocalizations;
    }
  }

  @override
  bool shouldReload(DoomiLocalizationsDelegate old) => false;
}
