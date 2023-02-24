import 'package:doomi/interfaces/themes.dart';
import 'package:flutter/material.dart';

class LightTheme extends ITheme {
  static final _instance = LightTheme._internal();

  LightTheme._internal()
      : super(
          background: Colors.white,
          name: 'Light theme',
          accentColor: Colors.red,
          textColor: Colors.black,
          textFieldBorderColor: Colors.grey,
          textFieldFocusedBorderColor: Colors.red,
          labelStyle: const TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        );

  factory LightTheme() => _instance;
}
