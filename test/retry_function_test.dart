import 'dart:io';

import 'package:doomi/utils/general_functions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'Exponential retry function',
    () {
      test('correct number of retries', () async {
        int i = 0;
        try {
          await retry(() async {
            i++;
            throw Exception();
          }, allowedRetries: 3);
        } on Exception catch (_) {}

        expect(i, 3);
      });

      test('correct return value when success', () async {
        late final int i;

        i = await retry<int>(() async => 45);

        expect(i, 45);
      });

      test('last exception is thrown', () async {
        expect(
          () async => await retry(() async => throw SocketException(''),
              allowedRetries: 3),
          throwsA(isA<SocketException>()),
        );
      });

      test('Function is wating for the right duration', () async {
        final stopwatch = Stopwatch()..start();

        try {
          await retry(
            () async => throw Exception(),
            durationFactor: const Duration(milliseconds: 50),
            allowedRetries: 3,
          );
        } on Exception catch (_) {}
        stopwatch.stop();

        expect(stopwatch.elapsedMilliseconds, greaterThanOrEqualTo(150));
      });

      test('onFirstThrow is being called when provided', () async {
        int? i;
        try {
          await retry(
            () async => throw Exception(),
            onFirstThrow: () => i = 5,
            durationFactor: const Duration(milliseconds: 50),
            allowedRetries: 3,
          );
        } on Exception catch (_) {}

        expect(i, 5);
      });
    },
  );
}
