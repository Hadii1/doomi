import 'dart:math';

import 'package:doomi/utils/app_localization.dart';
import 'package:flutter/material.dart';

String translate(String text, BuildContext context) {
  String translation = DoomiLocalizations.of(context).translate(text);
  return translation;
}

// Exponential back off retrying
Future<T> retry<T>(
  Future<T> Function() f, {
  int allowedRetries = 6,
  Function()? onFirstThrow,
  Duration durationFactor = const Duration(milliseconds: 600),
}) async {
  int attempts = 0;

  while (true) {
    try {
      return await f();
    } on Exception catch (e, _) {
      if (attempts == 0 && onFirstThrow != null) {
        onFirstThrow();
      }
      attempts++;

      if (attempts == allowedRetries) {
        rethrow;
      } else {
        await Future.delayed(durationFactor * pow(2, attempts - 1));
      }
    }
  }
}

