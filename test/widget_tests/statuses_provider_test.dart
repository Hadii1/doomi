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

  testWidgets('should display statuses when loaded',
      (WidgetTester tester) async {
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
                testList: [],
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
    expect(find.text(_dummyStatus.title), findsOneWidget);
  });

  testWidgets('Should delete status', (WidgetTester tester) async {
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
            onlineStorageProvider.overrideWith((ref) => MockIOnlineStorage()),
            userProvider
                .overrideWith((ref) => UserNotifier(testValue: _dummyUser)),
          ],
          child: _DeleteStatusTestWidget(_dummyProject),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('dummyStatus'), findsOneWidget);
    await tester.tap(find.text('Delete status'));
    await tester.pumpAndSettle();
    expect(find.text('dummyStatus'), findsNothing);
  });

  testWidgets('Should add status', (WidgetTester tester) async {
    var mockDb = MockIOnlineStorage();
    when(mockDb.addStatus(any)).thenAnswer(
      (v) async {
        return _dummyStatus;
      },
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
                testValue: [],
              ),
            ),
            onlineStorageProvider.overrideWith((ref) => MockIOnlineStorage()),
            userProvider
                .overrideWith((ref) => UserNotifier(testValue: _dummyUser)),
          ],
          child: _AddStatusTestWidget(_dummyProject),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text(_dummyStatus.title), findsNothing);
    await tester.tap(find.text('Add status'));
    await tester.pumpAndSettle();
    expect(find.text(_dummyStatus.title), findsOneWidget);
  });

  testWidgets('Should edit status', (WidgetTester tester) async {
    await tester.runAsync(
      () async => await tester.pumpWidget(
        ProviderScope(
          overrides: [
            statusesProvider.overrideWith(
              (ref, arg) => StatusesNotifier(
                project: _dummyProject.id,
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
            ),
            onlineStorageProvider.overrideWith((ref) => MockIOnlineStorage()),
            userProvider
                .overrideWith((ref) => UserNotifier(testValue: _dummyUser)),
          ],
          child: _EditStatusTestWidget(_dummyProject),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text(_dummyStatus.title), findsOneWidget);
    await tester.tap(find.text('Edit status'));
    await tester.pumpAndSettle();
    expect(find.text(_dummyStatus.title), findsNothing);
    expect(find.text('edited status'), findsOneWidget);
  });
}

class _EditStatusTestWidget extends ConsumerWidget {
  final Project project;

  const _EditStatusTestWidget(this.project);

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
            child: const Text('Edit status'),
            onPressed: () {
              final notifier = ref.read(statusesProvider(project.id).notifier);
              notifier.editStatus(Status(
                  id: 'id',
                  title: 'edited status',
                  description: 'description',
                  projectId: 'projectID'));
            },
          )),
    );
  }
}

class _AddStatusTestWidget extends ConsumerWidget {
  final Project project;

  const _AddStatusTestWidget(this.project);

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
            child: const Text('Add status'),
            onPressed: () {
              final notifier = ref.read(statusesProvider(project.id).notifier);
              notifier.addStatus(_dummyStatus);
            },
          )),
    );
  }
}

class _DeleteStatusTestWidget extends ConsumerWidget {
  final Project project;

  _DeleteStatusTestWidget(this.project);

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
            child: const Text('Delete status'),
            onPressed: () {
              final notifier = ref.read(statusesProvider(project.id).notifier);
              notifier.deleteStatus(
                Status(
                  id: 'id',
                  title: 'dummyStatus',
                  description: 'description',
                  projectId: 'projectId',
                ),
              );
            },
          )),
    );
  }
}
