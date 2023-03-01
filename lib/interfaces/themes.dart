import 'package:flutter/material.dart';

abstract class ITheme {
  final String name;
  final Color background;
  final Color backgroundLightContrast;
  final Color accentContrast;
  final Color textColor;
  final Color accentColor;

  final Color textFieldBorderColor;
  final Color textFieldFocusedBorderColor;
  final TextStyle labelStyle;
  final TextStyle hintStyle;
  final TextStyle title1;
  final TextStyle title2;
  final TextStyle title3;
  final TextStyle body1;
  final TextStyle body2;
  final TextStyle body3;
  final TextStyle body4;

  ITheme({
    required this.name,
    required this.background,
    required this.backgroundLightContrast,
    required this.accentContrast,
    required this.textFieldBorderColor,
    required this.textFieldFocusedBorderColor,
    required this.textColor,
    required this.accentColor,
    required this.hintStyle,
    required this.title1,
    required this.title2,
    required this.title3,
    required this.body1,
    required this.body2,
    required this.body3,
    required this.body4,
    required this.labelStyle,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ITheme && other.name == name;
  }

  @override
  int get hashCode {
    return name.hashCode;
  }
}
