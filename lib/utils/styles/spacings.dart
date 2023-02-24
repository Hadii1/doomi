import 'package:flutter/material.dart';

class Spacings {
  static const horizontalPadding =
      EdgeInsets.symmetric(horizontal: spacingFactor * 2);
  static const spacingBetweenElements = spacingFactor * 2.0;
  static const spacingFactor = 8.0;

  static EdgeInsets topScreenPadding(BuildContext context) => EdgeInsets.only(
      top: MediaQuery.of(context).padding.top + spacingFactor * 4);

  static EdgeInsets bottomScreenPadding(BuildContext context) =>
      EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + spacingFactor * 4);
}
