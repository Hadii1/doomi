import 'package:doomi/models/database%20models/project.dart';
import 'package:doomi/models/database%20models/user.dart';
import 'package:doomi/providers/errors_provider.dart';
import 'package:doomi/providers/projects_provider.dart';
import 'package:doomi/providers/user_provider.dart';
import 'package:doomi/screens/home.dart';
import 'package:doomi/utils/app_localization.dart';
import 'package:doomi/utils/enums.dart';
import 'package:doomi/widgets/loader.dart';
import 'package:doomi/widgets/project_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../mock_objects.dart/app_initialization_test.mocks.dart';
import '../mock_objects.dart/projects_provider_test.mocks.dart';

final _testUser = User(
  id: '',
  firstName: '',
  lastName: '',
  email: '',
);

final _dummyProject = Project(
  id: 'id',
  title: ' title',
  userId: '',
  description: ' description',
  startingDate: DateTime.now(),
  dueDate: DateTime.now(),
  status: ProjectStatus.active,
);
@GenerateNiceMocks([
  MockSpec<ErrorsNotifier>(),
])
void main() {
  testWidgets('should initialize with a loading state',
      (WidgetTester tester) async {
    await tester.runAsync(() async => await tester.pumpWidget(
          ProviderScope(
            overrides: [
              projectsProvider.overrideWith(
                (ref) => ProjectsNotifier(
                  userID: '',
                  errorsNotifier: MockErrorsNotifier(),
                  db: MockIOnlineStorage(),
                ),
              ),
              userProvider.overrideWith(
                (ref) => UserNotifier(
                  testValue: _testUser,
                ),
              ),
            ],
            child: const MaterialApp(
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                DoomiLocalizations.delegate,
              ],
              home: Scaffold(
                body: Home(),
              ),
            ),
          ),
        ));

    await tester.pump();
    expect(find.byType(Loader), findsOneWidget);
  });

  testWidgets('should display projects when loaded',
      (WidgetTester tester) async {
    await tester.runAsync(
      () async => tester.pumpWidget(
        ProviderScope(
          overrides: [
            userProvider.overrideWith(
              (ref) => UserNotifier(
                testValue: _testUser,
              ),
            ),
            projectsProvider.overrideWith(
              (ref) => ProjectsNotifier(
                userID: '',
                errorsNotifier: MockErrorsNotifier(),
                db: MockIOnlineStorage(),
                initial: [_dummyProject],
              ),
            ),
          ],
          child: const MaterialApp(
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              DoomiLocalizations.delegate,
            ],
            home: Scaffold(
              body: Home(),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(ProjectCard), findsOneWidget);
  });

  testWidgets('Should delete a project', (WidgetTester tester) async {
    await tester.runAsync(
      () async => await tester.pumpWidget(
        ProviderScope(
          overrides: [
            userProvider
                .overrideWith((ref) => UserNotifier(testValue: _testUser)),
            projectsProvider.overrideWith(
              (ref) => ProjectsNotifier(
                userID: '',
                errorsNotifier: MockErrorsNotifier(),
                db: MockIOnlineStorage(),
                initial: [
                  _dummyProject,
                ],
              ),
            ),
          ],
          child: const _DeleteProjectTestWidget(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text(_dummyProject.title), findsOneWidget);
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.text(_dummyProject.title), findsNothing);
  });

  testWidgets('Should add a project', (WidgetTester tester) async {
    var dbMock = MockIOnlineStorage();
    when(dbMock.addProject(any))
        .thenAnswer((realInvocation) async => _dummyProject);

    await tester.runAsync(
      () async => await tester.pumpWidget(
        ProviderScope(
          overrides: [
            userProvider
                .overrideWith((ref) => UserNotifier(testValue: _testUser)),
            projectsProvider.overrideWith(
              (ref) => ProjectsNotifier(
                errorsNotifier: MockErrorsNotifier(),
                userID: '',
                db: dbMock,
                initial: [],
              ),
            ),
          ],
          child: const _AddProjectTestWidget(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text(_dummyProject.title), findsNothing);
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.text(_dummyProject.title), findsOneWidget);
  });

  testWidgets('Should edit a project', (WidgetTester tester) async {
    await tester.runAsync(
      () async => await tester.pumpWidget(
        ProviderScope(
          overrides: [
            userProvider
                .overrideWith((ref) => UserNotifier(testValue: _testUser)),
            projectsProvider.overrideWith(
              (ref) => ProjectsNotifier(
                errorsNotifier: MockErrorsNotifier(),
                userID: '',
                db: MockIOnlineStorage(),
                initial: [_dummyProject],
              ),
            ),
          ],
          child: const _EditProjectTestWidget(),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text(_dummyProject.title), findsOneWidget);
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.text('edited project'), findsOneWidget);
  });
}

class _AddProjectTestWidget extends ConsumerWidget {
  const _AddProjectTestWidget();

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
        body: const Home(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final notifier = ref.read(projectsProvider.notifier);
            notifier.addProject(_dummyProject);
          },
        ),
      ),
    );
  }
}

class _DeleteProjectTestWidget extends ConsumerWidget {
  const _DeleteProjectTestWidget();

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
        body: const Home(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final notifier = ref.read(projectsProvider.notifier);
            notifier.deleteProject(_dummyProject);
          },
        ),
      ),
    );
  }
}

class _EditProjectTestWidget extends ConsumerWidget {
  const _EditProjectTestWidget();

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
        body: const Home(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final notifier = ref.read(projectsProvider.notifier);
            notifier.editProject(
              Project(
                id: 'id',
                userId: 'userId',
                title: 'edited project',
                description: 'description',
                startingDate: DateTime.now(),
                dueDate: DateTime.now(),
                status: ProjectStatus.active,
              ),
            );
          },
        ),
      ),
    );
  }
}
