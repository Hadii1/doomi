// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:flutter/cupertino.dart' as _i13;
import 'package:flutter/material.dart' as _i12;

import '../models/database%20models/project.dart' as _i14;
import '../screens/completed_tasks.dart' as _i4;
import '../screens/home.dart' as _i5;
import '../screens/login.dart' as _i2;
import '../screens/project_details.dart' as _i7;
import '../screens/project_statuses.dart' as _i10;
import '../screens/register.dart' as _i3;
import '../screens/settings.dart' as _i9;
import '../screens/splash.dart' as _i1;
import '../screens/task_details.dart' as _i8;
import '../screens/write_project.dart' as _i6;

class AppRouter extends _i11.RootStackRouter {
  AppRouter([_i12.GlobalKey<_i12.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i11.PageFactory> pagesMap = {
    SplashRouter.name: (routeData) {
      final args = routeData.argsAs<SplashRouterArgs>(
          orElse: () => const SplashRouterArgs());
      return _i11.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: _i1.SplashScreen(key: args.key),
      );
    },
    LoginRouter.name: (routeData) {
      return _i11.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const _i2.LoginScreen(),
      );
    },
    RegisterRouter.name: (routeData) {
      return _i11.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const _i3.RegisterScreen(),
      );
    },
    CompletedTasksRouter.name: (routeData) {
      final args = routeData.argsAs<CompletedTasksRouterArgs>();
      return _i11.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: _i4.CompletedTasksScreen(
          key: args.key,
          project: args.project,
        ),
      );
    },
    HomeRouter.name: (routeData) {
      return _i11.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const _i5.Home(),
      );
    },
    WriteProjectRouter.name: (routeData) {
      final args = routeData.argsAs<WriteProjectRouterArgs>(
          orElse: () => const WriteProjectRouterArgs());
      return _i11.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: _i6.WriteProjectScreen(
          key: args.key,
          project: args.project,
        ),
      );
    },
    ProjectDetailsRouter.name: (routeData) {
      final args = routeData.argsAs<ProjectDetailsRouterArgs>();
      return _i11.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: _i7.ProjectDetailsScreen(
          projectId: args.projectId,
          key: args.key,
        ),
      );
    },
    TaskDetailsRouter.name: (routeData) {
      final args = routeData.argsAs<TaskDetailsRouterArgs>();
      return _i11.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: _i8.TaskDetailsScreen(
          arg: args.arg,
          key: args.key,
        ),
      );
    },
    SettingsRouter.name: (routeData) {
      return _i11.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const _i9.SettingsScreen(),
      );
    },
    ProjectStatusesRouter.name: (routeData) {
      final args = routeData.argsAs<ProjectStatusesRouterArgs>();
      return _i11.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: _i10.ProjectStatuses(
          project: args.project,
          key: args.key,
        ),
      );
    },
  };

  @override
  List<_i11.RouteConfig> get routes => [
        _i11.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: 'splash',
          fullMatch: true,
        ),
        _i11.RouteConfig(
          SplashRouter.name,
          path: 'splash',
        ),
        _i11.RouteConfig(
          LoginRouter.name,
          path: 'login',
        ),
        _i11.RouteConfig(
          RegisterRouter.name,
          path: 'register',
        ),
        _i11.RouteConfig(
          CompletedTasksRouter.name,
          path: 'completedTasks',
        ),
        _i11.RouteConfig(
          HomeRouter.name,
          path: 'home',
        ),
        _i11.RouteConfig(
          WriteProjectRouter.name,
          path: 'writeProject',
        ),
        _i11.RouteConfig(
          ProjectDetailsRouter.name,
          path: 'projectDetails',
        ),
        _i11.RouteConfig(
          TaskDetailsRouter.name,
          path: 'taskDetails',
        ),
        _i11.RouteConfig(
          SettingsRouter.name,
          path: 'settings',
        ),
        _i11.RouteConfig(
          ProjectStatusesRouter.name,
          path: 'projectStatuses',
        ),
      ];
}

/// generated route for
/// [_i1.SplashScreen]
class SplashRouter extends _i11.PageRouteInfo<SplashRouterArgs> {
  SplashRouter({_i13.Key? key})
      : super(
          SplashRouter.name,
          path: 'splash',
          args: SplashRouterArgs(key: key),
        );

  static const String name = 'SplashRouter';
}

class SplashRouterArgs {
  const SplashRouterArgs({this.key});

  final _i13.Key? key;

  @override
  String toString() {
    return 'SplashRouterArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.LoginScreen]
class LoginRouter extends _i11.PageRouteInfo<void> {
  const LoginRouter()
      : super(
          LoginRouter.name,
          path: 'login',
        );

  static const String name = 'LoginRouter';
}

/// generated route for
/// [_i3.RegisterScreen]
class RegisterRouter extends _i11.PageRouteInfo<void> {
  const RegisterRouter()
      : super(
          RegisterRouter.name,
          path: 'register',
        );

  static const String name = 'RegisterRouter';
}

/// generated route for
/// [_i4.CompletedTasksScreen]
class CompletedTasksRouter
    extends _i11.PageRouteInfo<CompletedTasksRouterArgs> {
  CompletedTasksRouter({
    _i13.Key? key,
    required _i14.Project project,
  }) : super(
          CompletedTasksRouter.name,
          path: 'completedTasks',
          args: CompletedTasksRouterArgs(
            key: key,
            project: project,
          ),
        );

  static const String name = 'CompletedTasksRouter';
}

class CompletedTasksRouterArgs {
  const CompletedTasksRouterArgs({
    this.key,
    required this.project,
  });

  final _i13.Key? key;

  final _i14.Project project;

  @override
  String toString() {
    return 'CompletedTasksRouterArgs{key: $key, project: $project}';
  }
}

/// generated route for
/// [_i5.Home]
class HomeRouter extends _i11.PageRouteInfo<void> {
  const HomeRouter()
      : super(
          HomeRouter.name,
          path: 'home',
        );

  static const String name = 'HomeRouter';
}

/// generated route for
/// [_i6.WriteProjectScreen]
class WriteProjectRouter extends _i11.PageRouteInfo<WriteProjectRouterArgs> {
  WriteProjectRouter({
    _i13.Key? key,
    _i14.Project? project,
  }) : super(
          WriteProjectRouter.name,
          path: 'writeProject',
          args: WriteProjectRouterArgs(
            key: key,
            project: project,
          ),
        );

  static const String name = 'WriteProjectRouter';
}

class WriteProjectRouterArgs {
  const WriteProjectRouterArgs({
    this.key,
    this.project,
  });

  final _i13.Key? key;

  final _i14.Project? project;

  @override
  String toString() {
    return 'WriteProjectRouterArgs{key: $key, project: $project}';
  }
}

/// generated route for
/// [_i7.ProjectDetailsScreen]
class ProjectDetailsRouter
    extends _i11.PageRouteInfo<ProjectDetailsRouterArgs> {
  ProjectDetailsRouter({
    required String projectId,
    _i13.Key? key,
  }) : super(
          ProjectDetailsRouter.name,
          path: 'projectDetails',
          args: ProjectDetailsRouterArgs(
            projectId: projectId,
            key: key,
          ),
        );

  static const String name = 'ProjectDetailsRouter';
}

class ProjectDetailsRouterArgs {
  const ProjectDetailsRouterArgs({
    required this.projectId,
    this.key,
  });

  final String projectId;

  final _i13.Key? key;

  @override
  String toString() {
    return 'ProjectDetailsRouterArgs{projectId: $projectId, key: $key}';
  }
}

/// generated route for
/// [_i8.TaskDetailsScreen]
class TaskDetailsRouter extends _i11.PageRouteInfo<TaskDetailsRouterArgs> {
  TaskDetailsRouter({
    required _i8.TaskDetailsScreenArg arg,
    _i13.Key? key,
  }) : super(
          TaskDetailsRouter.name,
          path: 'taskDetails',
          args: TaskDetailsRouterArgs(
            arg: arg,
            key: key,
          ),
        );

  static const String name = 'TaskDetailsRouter';
}

class TaskDetailsRouterArgs {
  const TaskDetailsRouterArgs({
    required this.arg,
    this.key,
  });

  final _i8.TaskDetailsScreenArg arg;

  final _i13.Key? key;

  @override
  String toString() {
    return 'TaskDetailsRouterArgs{arg: $arg, key: $key}';
  }
}

/// generated route for
/// [_i9.SettingsScreen]
class SettingsRouter extends _i11.PageRouteInfo<void> {
  const SettingsRouter()
      : super(
          SettingsRouter.name,
          path: 'settings',
        );

  static const String name = 'SettingsRouter';
}

/// generated route for
/// [_i10.ProjectStatuses]
class ProjectStatusesRouter
    extends _i11.PageRouteInfo<ProjectStatusesRouterArgs> {
  ProjectStatusesRouter({
    required _i14.Project project,
    _i13.Key? key,
  }) : super(
          ProjectStatusesRouter.name,
          path: 'projectStatuses',
          args: ProjectStatusesRouterArgs(
            project: project,
            key: key,
          ),
        );

  static const String name = 'ProjectStatusesRouter';
}

class ProjectStatusesRouterArgs {
  const ProjectStatusesRouterArgs({
    required this.project,
    this.key,
  });

  final _i14.Project project;

  final _i13.Key? key;

  @override
  String toString() {
    return 'ProjectStatusesRouterArgs{project: $project, key: $key}';
  }
}
