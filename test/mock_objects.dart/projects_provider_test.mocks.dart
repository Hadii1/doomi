// Mocks generated by Mockito 5.3.2 from annotations
// in doomi/test/projects_provider_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:doomi/models/custom_notification.dart' as _i5;
import 'package:doomi/providers/errors_provider.dart' as _i2;
import 'package:flutter/material.dart' as _i6;
import 'package:flutter_riverpod/flutter_riverpod.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:state_notifier/state_notifier.dart' as _i7;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [ErrorsNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockErrorsNotifier extends _i1.Mock implements _i2.ErrorsNotifier {
  @override
  set timer(_i3.Timer? _timer) => super.noSuchMethod(
        Invocation.setter(
          #timer,
          _timer,
        ),
        returnValueForMissingStub: null,
      );
  @override
  set onError(_i4.ErrorListener? _onError) => super.noSuchMethod(
        Invocation.setter(
          #onError,
          _onError,
        ),
        returnValueForMissingStub: null,
      );
  @override
  bool get mounted => (super.noSuchMethod(
        Invocation.getter(#mounted),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  _i3.Stream<_i5.CustomNotification?> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i3.Stream<_i5.CustomNotification?>.empty(),
        returnValueForMissingStub: _i3.Stream<_i5.CustomNotification?>.empty(),
      ) as _i3.Stream<_i5.CustomNotification?>);
  @override
  set state(_i5.CustomNotification? value) => super.noSuchMethod(
        Invocation.setter(
          #state,
          value,
        ),
        returnValueForMissingStub: null,
      );
  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void hide() => super.noSuchMethod(
        Invocation.method(
          #hide,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  bool isNotificationDisplayed() => (super.noSuchMethod(
        Invocation.method(
          #isNotificationDisplayed,
          [],
        ),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  void showError(
    Exception? e,
    _i6.BuildContext? context, {
    StackTrace? s,
    bool? reportError = true,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #showError,
          [
            e,
            context,
          ],
          {
            #s: s,
            #reportError: reportError,
          },
        ),
        returnValueForMissingStub: null,
      );
  @override
  void recordError(
    Exception? e, {
    StackTrace? s,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #recordError,
          [e],
          {#s: s},
        ),
        returnValueForMissingStub: null,
      );
  @override
  bool updateShouldNotify(
    _i5.CustomNotification? old,
    _i5.CustomNotification? current,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateShouldNotify,
          [
            old,
            current,
          ],
        ),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  _i4.RemoveListener addListener(
    _i7.Listener<_i5.CustomNotification?>? listener, {
    bool? fireImmediately = true,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
          {#fireImmediately: fireImmediately},
        ),
        returnValue: () {},
        returnValueForMissingStub: () {},
      ) as _i4.RemoveListener);
}
