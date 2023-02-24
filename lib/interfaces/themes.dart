import 'package:flutter/material.dart';

abstract class ITheme {
  final String name;
  final Color background;
  final Color textColor;
  final Color accentColor;

  final Color textFieldBorderColor;
  final Color textFieldFocusedBorderColor;
  final TextStyle labelStyle;
  final TextStyle hintStyle;

  ITheme({
    required this.name,
    required this.background,
    required this.textFieldBorderColor,
    required this.textFieldFocusedBorderColor,
    required this.textColor,
    required this.accentColor,
    required this.hintStyle,
    required this.labelStyle,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ITheme && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
