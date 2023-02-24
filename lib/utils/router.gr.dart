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
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;

import '../screens/home.dart' as _i3;
import '../screens/login_screen.dart' as _i2;
import '../screens/splash_screen.dart' as _i1;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    SplashRouter.name: (routeData) {
      final args = routeData.argsAs<SplashRouterArgs>(
          orElse: () => const SplashRouterArgs());
      return _i4.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: _i1.SplashScreen(key: args.key),
      );
    },
    LoginRouter.name: (routeData) {
      return _i4.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const _i2.LoginScreen(),
      );
    },
    LoginHome.name: (routeData) {
      return _i4.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const _i3.Home(),
      );
    },
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: 'splash',
          fullMatch: true,
        ),
        _i4.RouteConfig(
          SplashRouter.name,
          path: 'splash',
        ),
        _i4.RouteConfig(
          LoginRouter.name,
          path: 'login',
        ),
        _i4.RouteConfig(
          LoginHome.name,
          path: 'home',
        ),
      ];
}

/// generated route for
/// [_i1.SplashScreen]
class SplashRouter extends _i4.PageRouteInfo<SplashRouterArgs> {
  SplashRouter({_i5.Key? key})
      : super(
          SplashRouter.name,
          path: 'splash',
          args: SplashRouterArgs(key: key),
        );

  static const String name = 'SplashRouter';
}

class SplashRouterArgs {
  const SplashRouterArgs({this.key});

  final _i5.Key? key;

  @override
  String toString() {
    return 'SplashRouterArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.LoginScreen]
class LoginRouter extends _i4.PageRouteInfo<void> {
  const LoginRouter()
      : super(
          LoginRouter.name,
          path: 'login',
        );

  static const String name = 'LoginRouter';
}

/// generated route for
/// [_i3.Home]
class LoginHome extends _i4.PageRouteInfo<void> {
  const LoginHome()
      : super(
          LoginHome.name,
          path: 'home',
        );

  static const String name = 'LoginHome';
}
