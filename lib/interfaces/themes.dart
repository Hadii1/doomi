import 'package:flutter/material.dart';

abstract class ITheme {
  final Color background;
  final Color textColor;

  ITheme({
    required this.background,
    required this.textColor,
  });
}
