import 'package:doomi/interfaces/themes.dart';
import 'package:flutter/material.dart';

class DarkTheme extends ITheme {
  static final _instance = DarkTheme._internal();

  DarkTheme._internal()
      : super(
          background: Colors.black87,
          backgroundLightContrast: const Color(0xff3b3c36),
          name: 'Dark theme',
          accentColor: Colors.red,
          accentContrast: Colors.white,
          textColor: Colors.white,
          textFieldBorderColor: Colors.grey,
          body1: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w400,
          ),
          body2: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          body3: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          body4: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          title1: const TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.w600,
          ),
          title2: const TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.w700,
          ),
          title3: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
          textFieldFocusedBorderColor: Colors.red,
          labelStyle: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        );

  factory DarkTheme() => _instance;
}
