// Mocks generated by Mockito 5.3.2 from annotations
// in doomi/test/unit_tests/locale_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:doomi/interfaces/local_storage.dart' as _i2;
import 'package:doomi/interfaces/themes.dart' as _i5;
import 'package:doomi/utils/enums.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;

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

/// A class which mocks [ILocalStorage].
///
/// See the documentation for Mockito's code generation for more information.
class MockILocalStorage extends _i1.Mock implements _i2.ILocalStorage {
  @override
  _i3.Future<void> initialize() => (super.noSuchMethod(
        Invocation.method(
          #initialize,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  void saveLocale(_i4.DoomiLocale? locale) => super.noSuchMethod(
        Invocation.method(
          #saveLocale,
          [locale],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void saveTheme(_i5.ITheme? theme) => super.noSuchMethod(
        Invocation.method(
          #saveTheme,
          [theme],
        ),
        returnValueForMissingStub: null,
      );
}