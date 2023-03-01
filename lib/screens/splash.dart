import 'dart:async';

import 'package:doomi/providers/initialization_provider.dart';
import 'package:doomi/providers/theme_provider.dart';
import 'package:doomi/services/navigation_service.dart';
import 'package:doomi/utils/enums.dart';
import 'package:doomi/utils/router.dart';
import 'package:doomi/widgets/error_widget.dart';
import 'package:doomi/widgets/fade_animation.dart';
import 'package:doomi/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerWidget {
  // We want at least 2.5 seconds before we navigate
  final Stopwatch stopwatch = Stopwatch()..start();

  SplashScreen({super.key});

  void onInitializationFinished(
      AppInitializationState s, BuildContext context) async {
    String destination =
        s == AppInitializationState.loggedIn ? Routes.home : Routes.register;
    if (stopwatch.elapsedMilliseconds > 2500) {
      NavigatorService.navigateAndClearHistory(destination, context);
    } else {
      await Future.delayed(
        Duration(milliseconds: 2500 - stopwatch.elapsedMilliseconds),
        () {
          NavigatorService.navigateAndClearHistory(destination, context);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    AsyncValue<AppInitializationState> state =
        ref.watch(appInitializationProvider);

    ref.listen(
      appInitializationProvider,
      (_, AsyncValue<AppInitializationState> next) {
        if (next is AsyncData) {
          onInitializationFinished(next.value!, context);
        }
      },
    );
    return Scaffold(
      backgroundColor: theme.background,
      body: FadeAnimation(
        hide: false,
        initialValue: 0,
        duration: const Duration(milliseconds: 1500),
        delay: const Duration(milliseconds: 500),
        automaticallyStart: true,
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: state.isLoading == false && state is AsyncError
                ? CustomErrorWidget(
                    onActionPressed: () {
                      ref.invalidate(appInitializationProvider);
                    },
                  )
                : state.isLoading && stopwatch.elapsedMilliseconds > 3000
                    ? const Loader()
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 48),
                        child: Image.asset(
                          'assets/pngs/splash.png',
                          height: 300,
                          width: 300,
                          alignment: Alignment.center,
                        ),
                      ),
          ),
        ),
      ),
    );
  }
}
