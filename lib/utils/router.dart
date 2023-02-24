import 'package:auto_route/auto_route.dart';
import 'package:doomi/screens/home.dart';
import 'package:doomi/screens/login_screen.dart';
import 'package:doomi/screens/splash_screen.dart';

class Routes {
  static const String splash = 'splash';
  static const String login = 'login';
  static const String home = 'home';
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
      page: Home,
      path: Routes.home,
      name: '${Routes.login}Home',
    ),
  ],
)
class $AppRouter {}
