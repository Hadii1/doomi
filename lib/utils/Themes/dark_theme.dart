import 'package:doomi/interfaces/themes.dart';
import 'package:flutter/material.dart';

class DarkTheme extends ITheme {
  static final _instance = DarkTheme._internal();

  DarkTheme._internal()
      : super(
          background: const Color(0xff000000),
          name: 'Dark theme',
          textFieldBorderColor: Colors.grey,
          textFieldFocusedBorderColor: Colors.red,
          accentColor: Colors.red,
          textColor: const Color(0xffffffff),
          labelStyle: const TextStyle(color: Colors.white, fontSize: 16),
          hintStyle: TextStyle(color: Colors.grey[50], fontSize: 14),
        );

  factory DarkTheme() => _instance;
}
