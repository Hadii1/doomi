import 'package:flutter/material.dart';

abstract class ITheme {
  final String name;
  final Color background;
  final Color textColor;

  ITheme({
    required this.name,
    required this.background,
    required this.textColor,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ITheme && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
