import 'package:doomi/interfaces/themes.dart';
import 'package:flutter/material.dart';

class DarkTheme extends ITheme {
  static final _instance = DarkTheme._internal();

  DarkTheme._internal()
      : super(
          background: const Color(0xff000000),
          name: 'Dark theme',
          textColor: const Color(0xffffffff),
        );

  factory DarkTheme() => _instance;
}
