import 'package:doomi/providers/locale_provider.dart';
import 'package:doomi/providers/theme_provider.dart';
import 'package:doomi/utils/Themes/light_theme.dart';
import 'package:doomi/utils/app_localization.dart';
import 'package:doomi/utils/extensions.dart';
import 'package:doomi/utils/router.gr.dart';
import 'package:doomi/widgets/in_app_notifications_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DoomiApp extends ConsumerWidget {
  DoomiApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localProvider);
    final theme = ref.watch(themeProvider);

    return CupertinoApp.router(
      routerDelegate: _appRouter.delegate(),
      supportedLocales: ref.read(themeProvider.notifier).supportedLocales,
      locale: locale.getOfficialLocal,
      routeInformationParser: _appRouter.defaultRouteParser(),
      theme: CupertinoThemeData(
        primaryColor: theme.accentColor,
        barBackgroundColor: theme.background,
        scaffoldBackgroundColor: theme.background,
        primaryContrastingColor: theme.accentColor,
        brightness: theme.name == LightTheme().name
            ? Brightness.light
            : Brightness.dark,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DoomiLocalizations.delegate,
      ],
      builder: (context, child) {
        return Stack(
          children: [
            child!,
            // This is to show notification card above the above from anywhere in the app.
            const NotificationWidget(),
          ],
        );
      },
    );
  }
}
