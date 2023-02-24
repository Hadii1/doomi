import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class NavigatorService {
  void navigateTo(String routeName, BuildContext context) {
    AutoRouter.of(context).pushNamed(routeName);
  }

  void navigateAndClearHistory(String routeName, BuildContext context) {
    AutoRouter.of(context).popUntilRoot();
    AutoRouter.of(context).pushNamed(routeName);
  }
}
