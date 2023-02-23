import 'package:doomi/interfaces/themes.dart';
import 'package:flutter/material.dart';

class LightTheme extends ITheme {
  static final _instance = LightTheme._internal();

  LightTheme._internal()
      : super(
          background: const Color(0xffffffff),
          name: 'Light theme',
          textColor: const Color(0xff000000),
        );

  factory LightTheme() => _instance;
}
