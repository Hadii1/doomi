import 'package:doomi/interfaces/themes.dart';
import 'package:flutter/material.dart';

class LightTheme extends ITheme {
  static final _instance = LightTheme._internal();

  LightTheme._internal()
      : super(
          background: Colors.white,
          backgroundLightContrast: const Color(0xffebecf0),
          name: 'Light theme',
          accentColor: Colors.red,
          textColor: Colors.black,
          accentContrast: Colors.white,
          textFieldBorderColor: Colors.grey,
          body1: const TextStyle(
            color: Colors.black,
            fontSize: 11,
            fontWeight: FontWeight.w400,
          ),
          body2: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          body3: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          body4: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          title1: const TextStyle(
            color: Colors.black,
            fontSize: 19,
            fontWeight: FontWeight.w600,
          ),
          title2: const TextStyle(
            color: Colors.black,
            fontSize: 21,
            fontWeight: FontWeight.w700,
          ),
          title3: const TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
          textFieldFocusedBorderColor: Colors.red,
          labelStyle: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        );

  factory LightTheme() => _instance;
}
