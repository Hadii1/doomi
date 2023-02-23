import 'package:doomi/utils/app_localization.dart';
import 'package:flutter/material.dart';

String translate(String text, BuildContext context) {
  String translation = DoomiLocalizations.of(context).translate(text);
  return translation;
}
