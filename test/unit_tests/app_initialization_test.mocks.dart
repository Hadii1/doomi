// Mocks generated by Mockito 5.3.2 from annotations
// in doomi/test/unit_tests/app_initialization_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:doomi/interfaces/auth.dart' as _i5;
import 'package:doomi/interfaces/local_storage.dart' as _i9;
import 'package:doomi/interfaces/online_storage.dart' as _i7;
import 'package:doomi/interfaces/themes.dart' as _i11;
import 'package:doomi/models/database%20models/project.dart' as _i2;
import 'package:doomi/models/database%20models/status.dart' as _i3;
import 'package:doomi/models/database%20models/task.dart' as _i4;
import 'package:doomi/models/database%20models/user.dart' as _i8;
import 'package:doomi/utils/enums.dart' as _i10;
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

class _FakeProject_0 extends _i1.SmartFake implements _i2.Project {
  _FakeProject_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeStatus_1 extends _i1.SmartFake implements _i3.Status {
  _FakeStatus_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTask_2 extends _i1.SmartFake implements _i4.Task {
  _FakeTask_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [IAuthService].
///
/// See the documentation for Mockito's code generation for more information.
class MockIAuthService extends _i1.Mock implements _i5.IAuthService {
  @override
  _i6.Future<String> registerUser(
    String? email,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #registerUser,
          [
            email,
            password,
          ],
        ),
        returnValue: _i6.Future<String>.value(''),
        returnValueForMissingStub: _i6.Future<String>.value(''),
      ) as _i6.Future<String>);
  @override
  _i6.Future<String> signIn(
    String? email,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #signIn,
          [
            email,
            password,
          ],
        ),
        returnValue: _i6.Future<String>.value(''),
        returnValueForMissingStub: _i6.Future<String>.value(''),
      ) as _i6.Future<String>);
  @override
  _i6.Future<void> signOut() => (super.noSuchMethod(
        Invocation.method(
          #signOut,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
}

/// A class which mocks [IOnlineStorage].
///
/// See the documentation for Mockito's code generation for more information.
class MockIOnlineStorage extends _i1.Mock implements _i7.IOnlineStorage {
  @override
  _i6.Future<_i8.User?> getUser(String? id) => (super.noSuchMethod(
        Invocation.method(
          #getUser,
          [id],
        ),
        returnValue: _i6.Future<_i8.User?>.value(),
        returnValueForMissingStub: _i6.Future<_i8.User?>.value(),
      ) as _i6.Future<_i8.User?>);
  @override
  _i6.Future<void> saveUser(_i8.User? user) => (super.noSuchMethod(
        Invocation.method(
          #saveUser,
          [user],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<_i2.Project> addProject(_i2.Project? project) =>
      (super.noSuchMethod(
        Invocation.method(
          #addProject,
          [project],
        ),
        returnValue: _i6.Future<_i2.Project>.value(_FakeProject_0(
          this,
          Invocation.method(
            #addProject,
            [project],
          ),
        )),
        returnValueForMissingStub: _i6.Future<_i2.Project>.value(_FakeProject_0(
          this,
          Invocation.method(
            #addProject,
            [project],
          ),
        )),
      ) as _i6.Future<_i2.Project>);
  @override
  _i6.Future<void> deleteProject(String? projectId) => (super.noSuchMethod(
        Invocation.method(
          #deleteProject,
          [projectId],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<void> updateProject(_i2.Project? project) => (super.noSuchMethod(
        Invocation.method(
          #updateProject,
          [project],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<List<_i2.Project>> getUserProjects(String? userId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUserProjects,
          [userId],
        ),
        returnValue: _i6.Future<List<_i2.Project>>.value(<_i2.Project>[]),
        returnValueForMissingStub:
            _i6.Future<List<_i2.Project>>.value(<_i2.Project>[]),
      ) as _i6.Future<List<_i2.Project>>);
  @override
  _i6.Future<_i3.Status> addStatus(_i3.Status? status) => (super.noSuchMethod(
        Invocation.method(
          #addStatus,
          [status],
        ),
        returnValue: _i6.Future<_i3.Status>.value(_FakeStatus_1(
          this,
          Invocation.method(
            #addStatus,
            [status],
          ),
        )),
        returnValueForMissingStub: _i6.Future<_i3.Status>.value(_FakeStatus_1(
          this,
          Invocation.method(
            #addStatus,
            [status],
          ),
        )),
      ) as _i6.Future<_i3.Status>);
  @override
  _i6.Future<void> deleteStatus(String? statusId) => (super.noSuchMethod(
        Invocation.method(
          #deleteStatus,
          [statusId],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<void> updateStatus(_i3.Status? status) => (super.noSuchMethod(
        Invocation.method(
          #updateStatus,
          [status],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<List<_i3.Status>> getProjectStatuses(String? projectId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getProjectStatuses,
          [projectId],
        ),
        returnValue: _i6.Future<List<_i3.Status>>.value(<_i3.Status>[]),
        returnValueForMissingStub:
            _i6.Future<List<_i3.Status>>.value(<_i3.Status>[]),
      ) as _i6.Future<List<_i3.Status>>);
  @override
  _i6.Future<_i4.Task> addTask(_i4.Task? task) => (super.noSuchMethod(
        Invocation.method(
          #addTask,
          [task],
        ),
        returnValue: _i6.Future<_i4.Task>.value(_FakeTask_2(
          this,
          Invocation.method(
            #addTask,
            [task],
          ),
        )),
        returnValueForMissingStub: _i6.Future<_i4.Task>.value(_FakeTask_2(
          this,
          Invocation.method(
            #addTask,
            [task],
          ),
        )),
      ) as _i6.Future<_i4.Task>);
  @override
  _i6.Future<void> deleteTask(String? taskId) => (super.noSuchMethod(
        Invocation.method(
          #deleteTask,
          [taskId],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<void> updateTask(_i4.Task? task) => (super.noSuchMethod(
        Invocation.method(
          #updateTask,
          [task],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<List<_i4.Task>> getProjectTasks(String? projectId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getProjectTasks,
          [projectId],
        ),
        returnValue: _i6.Future<List<_i4.Task>>.value(<_i4.Task>[]),
        returnValueForMissingStub:
            _i6.Future<List<_i4.Task>>.value(<_i4.Task>[]),
      ) as _i6.Future<List<_i4.Task>>);
}

/// A class which mocks [ILocalStorage].
///
/// See the documentation for Mockito's code generation for more information.
class MockILocalStorage extends _i1.Mock implements _i9.ILocalStorage {
  @override
  _i6.Future<void> initialize() => (super.noSuchMethod(
        Invocation.method(
          #initialize,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  void saveLocale(_i10.DoomiLocale? locale) => super.noSuchMethod(
        Invocation.method(
          #saveLocale,
          [locale],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void saveTheme(_i11.ITheme? theme) => super.noSuchMethod(
        Invocation.method(
          #saveTheme,
          [theme],
        ),
        returnValueForMissingStub: null,
      );
}