// ignore_for_file: use_build_context_synchronously, avoid_init_to_null

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:doomi/models/custom_notification.dart';
import 'package:doomi/utils/exceptions.dart';
import 'package:doomi/utils/general_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final errorsProvider =
    StateNotifierProvider<ErrorsNotifier, CustomNotification?>(
  (_) => ErrorsNotifier(),
);

// Null state refers to initial state with no notification to show/hide
class ErrorsNotifier extends StateNotifier<CustomNotification?> {
  ErrorsNotifier() : super(null);

  Timer? timer = null;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void showNotification(String text) async {
    if (isNotificationDisplayed()) {
      await _hideDisplayedNotification();
    }

    CustomNotification notification = CustomNotification(
      message: text,
      useErrorColor: false,
      duration: const Duration(seconds: 3),
    );

    state = notification;

    // Wait for the duration of the
    // notification then hide it.
    timer = Timer(notification.duration, () {
      state = notification.hideNotication();
    });
  }

  void hide() {
    if (state != null && state!.hide == false) {
      if (timer != null && timer!.isActive) {
        timer!.cancel();
      }
      CustomNotification notification = state!.hideNotication();
      state = notification;
    }
  }

  bool isNotificationDisplayed() => state != null && state!.hide == false;

  /// This method handles showing custom error messages
  /// for different exceptions.
  void showError(Exception e, BuildContext context,
      {StackTrace? s, bool reportError = true}) async {
    if (reportError) recordError(e, s: s);

    late String errorMsg;

    if (isNotificationDisplayed()) {
      await _hideDisplayedNotification();
    }

    switch (e.runtimeType) {
      case EmailAlreadyInUseException:
        errorMsg = translate('error.emailAlreadyInUse', context);
        break;

      case InvalidEmailException:
        errorMsg = translate('error.invalidEmail', context);
        break;

      case HandshakeException:
      case SocketException:
        errorMsg = translate('error.internetError', context);
        break;

      case MissingInfoException:
        errorMsg = translate('error.missingInfo', context);
        break;

      case StartDateAfterThanDueDate:
        errorMsg = translate('error.startDateAfterDueDate', context);
        break;

      case UserNotFound:
        errorMsg = translate('error.userNotFound', context);
        break;

      case WrongPasswordException:
        errorMsg = translate('error.wrongPassword', context);
        break;

      case WeakPasswordException:
        errorMsg = translate('error.weakPassword', context);
        break;

      case PasswordsNotMatchingException:
        errorMsg = translate('error.passwordsNotMatching', context);
        break;

      case UnknownException:
      default:
        errorMsg = translate('error.unknownError', context);
    }

    CustomNotification notification = CustomNotification(
      message: errorMsg,
      duration: const Duration(seconds: 3),
    );

    state = notification;

    // Wait for the duration of the
    // notification then hide it.
    timer = Timer(notification.duration, () {
      state = notification.hideNotication();
    });
  }

  void recordError(Exception e, {StackTrace? s}) {
    // TODO
    // if (Environment.config.reportExceptions && !kDebugMode) {
    //   Type type = e.runtimeType;
    //   List<Type> ignoredExceptions = [
    //     InvalidEmailException,
    //     EmailAlreadyInUseException,
    //     InvalidCodeException,
    //     ImagePermissionException,
    //     UserNotFoundException,
    //     NumberAlreadyInUseException,
    //     ValidationExpiredException,
    //   ];
    //   if (ignoredExceptions.contains(type) == false) {
    //     Sentry.captureException(e, stackTrace: s);
    //   }
  }

  Future<void> _hideDisplayedNotification() async {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }
    // Close the old notification before showing the new one
    CustomNotification notification = state!.hideNotication();
    state = notification;
    // Wait for the notification to slide up before showing the new one
    await Future.delayed(const Duration(milliseconds: 300));
  }
}
