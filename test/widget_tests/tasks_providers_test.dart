import 'package:doomi/models/database%20models/project.dart';
import 'package:doomi/models/database%20models/status.dart';
import 'package:doomi/models/database%20models/task.dart';
import 'package:doomi/models/database%20models/user.dart';
import 'package:doomi/providers/online_storage_provider.dart';
import 'package:doomi/providers/statuses_provider.dart';
import 'package:doomi/providers/tasks_provider.dart';
import 'package:doomi/providers/user_provider.dart';
import 'package:doomi/screens/project_statuses.dart';
import 'package:doomi/utils/app_localization.dart';
import 'package:doomi/utils/enums.dart';
import 'package:doomi/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mock_objects.dart/app_initialization_test.mocks.dart';
import '../mock_objects.dart/projects_provider_test.mocks.dart';

Project _dummyProject = Project(
  id: 'id',
  userId: 'userId',
  title: 'title',
  description: 'description',
  startingDate: DateTime.now(),
  dueDate: DateTime.now(),
  status: ProjectStatus.active,
);

Status _dummyStatus = Status(
  id: 'id',
  title: 'dummyStatus',
  description: 'description',
  projectId: 'projectID',
);

Task _dummyTask = Task(
  id: 'id',
  statusId: 'id',
  projectID: 'projectID',
  title: 'dummyTask',
  istrackingTime: false,
  description: 'description',
  startingDate: DateTime.now(),
  dueDate: DateTime.now(),
  timeSpent: Duration.zero,
);

User _dummyUser = User(
  id: '',
  firstName: '',
  lastName: '',
  email: '',
);

void main() {
  testWidgets('should initialize with a loading state',
      (WidgetTester tester) async {
    await tester.runAsync(() async => await tester.pumpWidget(
          ProviderScope(
            overrides: [
              onlineStorageProvider.overrideWith((ref) => MockIOnlineStorage()),
              userProvider.overrideWith(
                (ref) => UserNotifier(
                  testValue: _dummyUser,
                ),
              ),
            ],
            child: MaterialApp(
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                DoomiLocalizations.delegate,
              ],
              home: ProjectStatuses(
                project: _dummyProject,
              ),
            ),
          ),
        ));

    await tester.pump();
    expect(find.byType(Loader), findsOneWidget);
  });

  testWidgets('should display tasks when loaded', (WidgetTester tester) async {
    await tester.runAsync(
      () async => tester.pumpWidget(
        ProviderScope(
          overrides: [
            onlineStorageProvider.overrideWith((ref) => MockIOnlineStorage()),
            userProvider
                .overrideWith((ref) => UserNotifier(testValue: _dummyUser)),
            statusesProvider.overrideWith(
              (ref, arg) => StatusesNotifier(
                project: arg,
                db: MockIOnlineStorage(),
                errorsNotifier: MockErrorsNotifier(),
                testValue: [_dummyStatus],
              ),
            ),
            tasksProvider.overrideWith(
              (ref, arg) => TasksNotifier(
                project: arg,
                errorsNotifier: MockErrorsNotifier(),
                db: MockIOnlineStorage(),
                testList: [_dummyTask],
              ),
            )
          ],
          child: MaterialApp(
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              DoomiLocalizations.delegate,
            ],
            home: Scaffold(
              body: ProjectStatuses(
                project: _dummyProject,
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text(_dummyTask.title), findsOneWidget);
  });

  testWidgets('Should delete task', (WidgetTester tester) async {
    await tester.runAsync(
      () async => await tester.pumpWidget(
        ProviderScope(
          overrides: [
            statusesProvider.overrideWith(
              (ref, arg) => StatusesNotifier(
                project: _dummyProject.id,
                db: MockIOnlineStorage(),
                errorsNotifier: MockErrorsNotifier(),
                testValue: [
                  _dummyStatus,
                ],
              ),
            ),
            tasksProvider.overrideWith(
              (ref, arg) => TasksNotifier(
                  project: _dummyProject.id,
                  errorsNotifier: MockErrorsNotifier(),
                  db: MockIOnlineStorage(),
                  testList: [
                    _dummyTask,
                  ]),
            ),
            onlineStorageProvider.overrideWith((ref) => MockIOnlineStorage()),
            userProvider
                .overrideWith((ref) => UserNotifier(testValue: _dummyUser)),
          ],
          child: _DeleteTaskWidget(_dummyProject),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text(_dummyTask.title), findsOneWidget);
    await tester.tap(find.text('Delete task'));
    await tester.pumpAndSettle();
    expect(find.text(_dummyTask.title), findsNothing);
  });

  testWidgets('Should add task', (WidgetTester tester) async {
    var mockDb = MockIOnlineStorage();
    when(mockDb.addTask(any)).thenAnswer(
      (v) async => _dummyTask,
    );
    await tester.runAsync(
      () async => await tester.pumpWidget(
        ProviderScope(
          overrides: [
            statusesProvider.overrideWith(
              (ref, arg) => StatusesNotifier(
                  project: _dummyProject.id,
                  db: mockDb,
                  errorsNotifier: MockErrorsNotifier(),
                  testValue: [_dummyStatus]),
            ),
            tasksProvider.overrideWith(
              (ref, arg) => TasksNotifier(
                project: arg,
                errorsNotifier: MockErrorsNotifier(),
                db: mockDb,
                testList: [],
              ),
            ),
            onlineStorageProvider.overrideWith((ref) => MockIOnlineStorage()),
            userProvider
                .overrideWith((ref) => UserNotifier(testValue: _dummyUser)),
          ],
          child: _AddTaskTestWidget(_dummyProject),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text(_dummyTask.title), findsNothing);
    await tester.tap(find.text('Add task'));
    await tester.pumpAndSettle();
    expect(find.text(_dummyTask.title), findsOneWidget);
  });

  testWidgets('Should edit task', (WidgetTester tester) async {
    await tester.runAsync(
      () async => await tester.pumpWidget(
        ProviderScope(
          overrides: [
            statusesProvider.overrideWith(
              (ref, arg) => StatusesNotifier(
                  project: _dummyProject.id,
                  db: MockIOnlineStorage(),
                  errorsNotifier: MockErrorsNotifier(),
                  testValue: [_dummyStatus]),
            ),
            tasksProvider.overrideWith(
              (ref, arg) => TasksNotifier(
                project: arg,
                errorsNotifier: MockErrorsNotifier(),
                db: MockIOnlineStorage(),
                testList: [_dummyTask],
              ),
            ),
            onlineStorageProvider.overrideWith((ref) => MockIOnlineStorage()),
            userProvider
                .overrideWith((ref) => UserNotifier(testValue: _dummyUser)),
          ],
          child: _EditTaskTestWidget(_dummyProject),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text(_dummyTask.title), findsOneWidget);
    await tester.tap(find.text('Edit task'));
    await tester.pumpAndSettle();
    expect(find.text(_dummyTask.title), findsNothing);
    expect(find.text('edited task'), findsOneWidget);
  });
}

class _DeleteTaskWidget extends ConsumerWidget {
  final Project project;

  _DeleteTaskWidget(this.project);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DoomiLocalizations.delegate,
      ],
      home: Scaffold(
          body: ProjectStatuses(
            project: project,
          ),
          floatingActionButton: FloatingActionButton(
            child: const Text('Delete task'),
            onPressed: () {
              final notifier = ref.read(tasksProvider(project.id).notifier);
              notifier.deleteTask(_dummyTask);
            },
          )),
    );
  }
}

class _AddTaskTestWidget extends ConsumerWidget {
  final Project project;

  const _AddTaskTestWidget(this.project);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DoomiLocalizations.delegate,
      ],
      home: Scaffold(
          body: ProjectStatuses(
            project: project,
          ),
          floatingActionButton: FloatingActionButton(
            child: const Text('Add task'),
            onPressed: () {
              final notifier = ref.read(tasksProvider(project.id).notifier);
              notifier.addTask(_dummyTask);
            },
          )),
    );
  }
}

class _EditTaskTestWidget extends ConsumerWidget {
  final Project project;

  const _EditTaskTestWidget(this.project);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DoomiLocalizations.delegate,
      ],
      home: Scaffold(
          body: ProjectStatuses(
            project: project,
          ),
          floatingActionButton: FloatingActionButton(
            child: const Text('Edit task'),
            onPressed: () {
              final notifier = ref.read(tasksProvider(project.id).notifier);
              notifier.editTask(
                Task(
                  id: 'id',
                  statusId: 'id',
                  projectID: 'id',
                  title: 'edited task',
                  istrackingTime: false,
                  description: 'description',
                  startingDate: DateTime.now(),
                  dueDate: DateTime.now(),
                  timeSpent: Duration.zero,
                ),
              );
            },
          )),
    );
  }
}
