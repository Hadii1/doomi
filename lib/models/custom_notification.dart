import 'package:flutter/material.dart';

class CustomNotification {
  final String message;
  // How long to show the notifications
  final Duration duration;
  // To hide the notification without losing it's content
  final bool hide;
  final bool useErrorColor;

  CustomNotification({
    this.hide = false,
    this.duration = const Duration(seconds: 3),
    this.useErrorColor = true,
    required this.message,
  });

  static const checkMarkIcon = Icons.check_circle;

  CustomNotification hideNotication() {
    return CustomNotification(
      message: message,
      duration: duration,
      hide: true,
      useErrorColor: useErrorColor,
    );
  }
}
