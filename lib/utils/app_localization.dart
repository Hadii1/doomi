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

  static const _DoomiLocalizationsDelegate delegate =
      _DoomiLocalizationsDelegate();

  late final Map<String, String> _localizedValues;
  static final List<String> languages = ['en', 'ar'];

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
      debugPrint('couldn\'t find translation for: $key');
      return key;
    }
    return translation;
  }
}

class _DoomiLocalizationsDelegate
    extends LocalizationsDelegate<DoomiLocalizations> {
  const _DoomiLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      DoomiLocalizations.languages.contains(locale.languageCode);

  @override
  Future<DoomiLocalizations> load(Locale locale) async {
    DoomiLocalizations convivioLocalizations = DoomiLocalizations(locale);
    await convivioLocalizations.load();
    return convivioLocalizations;
  }

  @override
  bool shouldReload(_DoomiLocalizationsDelegate old) => false;
}
