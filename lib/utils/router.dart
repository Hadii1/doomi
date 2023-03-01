import 'package:auto_route/auto_route.dart';
import 'package:doomi/screens/completed_tasks.dart';
import 'package:doomi/screens/register.dart';
import 'package:doomi/screens/write_project.dart';
import 'package:doomi/screens/home.dart';
import 'package:doomi/screens/login.dart';
import 'package:doomi/screens/project_statuses.dart';
import 'package:doomi/screens/project_details.dart';
import 'package:doomi/screens/settings.dart';
import 'package:doomi/screens/splash.dart';
import 'package:doomi/screens/task_details.dart';

class Routes {
  static const String splash = 'splash';
  static const String login = 'login';
  static const String register = 'register';
  static const String home = 'home';
  static const String writeProject = 'writeProject';
  static const String projectDetails = 'projectDetails';
  static const String projectStatuses = 'projectStatuses';
  static const String completedTasks = 'completedTasks';
  static const String taskDetails = 'taskDetails';
  static const String settings = 'settings';
}

@CupertinoAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      initial: true,
      page: SplashScreen,
      path: Routes.splash,
      name: '${Routes.splash}Router',
    ),
    AutoRoute(
      page: LoginScreen,
      path: Routes.login,
      name: '${Routes.login}Router',
    ),
    AutoRoute(
      page: RegisterScreen,
      path: Routes.register,
      name: '${Routes.register}Router',
    ),
    AutoRoute(
      page: CompletedTasksScreen,
      path: Routes.completedTasks,
      name: '${Routes.completedTasks}Router',
    ),
    AutoRoute(
      page: Home,
      path: Routes.home,
      name: '${Routes.home}Router',
    ),
    AutoRoute(
      page: WriteProjectScreen,
      path: Routes.writeProject,
      name: '${Routes.writeProject}Router',
    ),
    AutoRoute(
      page: ProjectDetailsScreen,
      path: Routes.projectDetails,
      name: '${Routes.projectDetails}Router',
    ),
    AutoRoute(
      page: TaskDetailsScreen,
      path: Routes.taskDetails,
      name: '${Routes.taskDetails}Router',
    ),
    AutoRoute(
      page: SettingsScreen,
      path: Routes.settings,
      name: '${Routes.settings}Router',
    ),
    AutoRoute(
      page: ProjectStatuses,
      path: Routes.projectStatuses,
      name: '${Routes.projectStatuses}Router',
    ),
  ],
)
class $AppRouter {}
