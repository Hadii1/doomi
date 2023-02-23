import 'package:doomi/interfaces/themes.dart';
import 'package:flutter/material.dart';

class DarkTheme extends ITheme {
  DarkTheme({
    super.name = 'Dark Theme',
    super.background = const Color(0xff000000),
    super.textColor = const Color(0xffffffff),
  });
}
