import 'package:auto_route/auto_route.dart';
import 'package:doomi/models/database%20models/project.dart';
import 'package:doomi/screens/task_details.dart';
import 'package:doomi/utils/router.dart';
import 'package:doomi/utils/router.gr.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigatorService {
  static void navigateTo(String routeName, BuildContext context) {
    AutoRouter.of(context).pushNamed(routeName);
  }

  static void navigateWithArg(
      String routeName, BuildContext context, Object arg) {
    late PageRouteInfo pageRoute;

    switch (routeName) {
      case Routes.writeProject:
        pageRoute = WriteProjectRouter(project: arg as Project?);
        break;

      case Routes.projectDetails:
        pageRoute = ProjectDetailsRouter(projectId: arg as String);
        break;

      case Routes.completedTasks:
        pageRoute = CompletedTasksRouter(project: arg as Project);
        break;

      case Routes.taskDetails:
        pageRoute = TaskDetailsRouter(arg: arg as TaskDetailsScreenArg);
        break;

      case Routes.projectStatuses:
        pageRoute = ProjectStatusesRouter(project: arg as Project);
        break;

      default:
        throw Exception(
            'Either the route name: $routeName is invalid or this case is missing');
    }
    AutoRouter.of(context).push(pageRoute);
  }

  static void pop(BuildContext context) {
    AutoRouter.of(context).pop();
  }

  static void navigateAndClearHistory(String routeName, BuildContext context) {
    AutoRouter.of(context).removeUntil((route) => false);
    AutoRouter.of(context).pushNamed(routeName);
  }
}
