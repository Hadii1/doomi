import 'package:doomi/models/database%20models/task.dart';
import 'package:doomi/providers/errors_provider.dart';
import 'package:doomi/providers/online_storage_provider.dart';
import 'package:doomi/providers/tasks_provider.dart';
import 'package:doomi/screens/task_details.dart';
import 'package:doomi/utils/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock_objects.dart/app_initialization_test.mocks.dart';

void main() {
  group('TimingCard', () {
    late final MockIOnlineStorage mockIOnlineStorage;
    setUpAll(() {
      mockIOnlineStorage = MockIOnlineStorage();
    });

    testWidgets('renders duration correctly', (WidgetTester tester) async {
      Task task = Task(
        id: 'task_id',
        projectID: '',
        title: 'Test Task',
        description: 'This is a test task',
        statusId: '',
        dueDate: DateTime.now(),
        startingDate: DateTime.now(),
        istrackingTime: true,
        timeSpent: const Duration(hours: 2),
        latestShiftDate: DateTime.now().subtract(const Duration(minutes: 30)),
      );

      await tester.runAsync(
        () async => await tester.pumpWidget(
          ProviderScope(
            overrides: [
              onlineStorageProvider.overrideWith((ref) => mockIOnlineStorage),
              tasksProvider.overrideWith(
                (ref, arg) => TasksNotifier(
                  testList: [task],
                  db: MockIOnlineStorage(),
                  errorsNotifier: ErrorsNotifier(),
                  project: arg,
                ),
              )
            ],
            child: MaterialApp(
              localizationsDelegates: const [
                DoomiLocalizationsDelegate(isInTestingMode: true),
              ],
              home: Scaffold(
                body: TimingCard(task: task),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(
        find.text('totalTimeSpent: 02:30:00'),
        findsOneWidget,
      );

      expect(
        find.text('stopTracking'),
        findsOneWidget,
      );
    });

    testWidgets('can start tracking time', (WidgetTester tester) async {
      Task task = Task(
        id: 'task_id',
        projectID: '',
        title: 'Test Task',
        description: 'This is a test task',
        statusId: '',
        dueDate: DateTime.now(),
        startingDate: DateTime.now(),
        istrackingTime: false,
        timeSpent: const Duration(seconds: 10),
        latestShiftDate: null,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            onlineStorageProvider.overrideWith((ref) => mockIOnlineStorage),
            tasksProvider.overrideWith((ref, arg) => TasksNotifier(
                  testList: [task],
                  db: MockIOnlineStorage(),
                  errorsNotifier: ErrorsNotifier(),
                  project: arg,
                ))
          ],
          child: MaterialApp(
            localizationsDelegates: const [
              DoomiLocalizationsDelegate(isInTestingMode: true),
            ],
            home: Scaffold(
              body: TimingCard(task: task),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('totalTimeSpent: 00:00:10'), findsOneWidget);
      expect(find.text('startTracking'), findsOneWidget);

      await tester.tap(find.text('startTracking'));
      await tester.pumpAndSettle();

      expect(find.text('stopTracking'), findsOneWidget);
    });

    testWidgets('can stop tracking time', (WidgetTester tester) async {
      Task task = Task(
        id: 'task_id',
        projectID: '',
        title: 'Test Task',
        description: 'This is a test task',
        statusId: '',
        dueDate: DateTime.now(),
        startingDate: DateTime.now(),
        istrackingTime: true,
        timeSpent: const Duration(hours: 10),
        latestShiftDate: DateTime.now().subtract(const Duration(hours: 1)),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            onlineStorageProvider.overrideWith((ref) => mockIOnlineStorage),
            tasksProvider.overrideWith(
              (ref, arg) => TasksNotifier(
                testList: [task],
                db: MockIOnlineStorage(),
                errorsNotifier: ErrorsNotifier(),
                project: arg,
              ),
            )
          ],
          child: MaterialApp(
            localizationsDelegates: const [
              DoomiLocalizationsDelegate(isInTestingMode: true),
            ],
            home: Scaffold(
              body: TimingCard(task: task),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('totalTimeSpent: 11:00:00'), findsOneWidget);
      expect(find.text('stopTracking'), findsOneWidget);
      expect(task.istrackingTime, isTrue);
      expect(task.latestShiftDate, isNotNull);

      await tester.tap(find.text('stopTracking'));
      await tester.pumpAndSettle();

      expect(find.text('startTracking'), findsOneWidget);
    });
  });
}
