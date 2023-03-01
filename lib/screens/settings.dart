import 'package:doomi/providers/auth_service_provider.dart';
import 'package:doomi/providers/locale_provider.dart';
import 'package:doomi/providers/theme_provider.dart';
import 'package:doomi/services/navigation_service.dart';
import 'package:doomi/utils/Themes/dark_theme.dart';
import 'package:doomi/utils/Themes/light_theme.dart';
import 'package:doomi/utils/enums.dart';
import 'package:doomi/utils/general_functions.dart';
import 'package:doomi/utils/router.dart';
import 'package:doomi/utils/styles/spacings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final locale = ref.watch(localProvider);

    return Scaffold(
      backgroundColor: theme.background,
      appBar: CupertinoNavigationBar(
        middle: Text(
          translate('settings', context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Spacings.spacingFactor * 2,
          vertical: Spacings.spacingFactor * 2,
        ),
        child: Column(
          children: [
            _ActionTile(
              label: translate('signOut', context),
              icon: CupertinoIcons.forward,
              onTap: () {
                ref.read(authServiceProvider).signOut();
                NavigatorService.navigateAndClearHistory(
                    Routes.register, context);
              },
            ),
            const SizedBox(
              height: Spacings.spacingFactor,
            ),
            _ActionTile(
              label: theme.name == LightTheme().name
                  ? translate('switchToDarkTheme', context)
                  : translate('switchToLightTheme', context),
              icon: theme.name == LightTheme().name
                  ? Icons.dark_mode
                  : Icons.light_mode,
              onTap: () {
                ref.read(themeProvider.notifier).setTheme(
                      theme.name == LightTheme().name
                          ? DarkTheme()
                          : LightTheme(),
                    );
              },
            ),
            const SizedBox(
              height: Spacings.spacingFactor,
            ),
            _ActionTile(
              label: locale == DoomiLocale.english ? 'العربية' : 'English',
              icon: Icons.language,
              onTap: () {
                ref.read(localProvider.notifier).setLocal(
                      locale == DoomiLocale.english
                          ? DoomiLocale.arabic
                          : DoomiLocale.english,
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionTile extends ConsumerWidget {
  const _ActionTile({
    Key? key,
    required this.label,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  final String label;
  final IconData icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(Spacings.spacingFactor * 2),
            decoration: BoxDecoration(
              color: theme.backgroundLightContrast,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: theme.body3,
                  ),
                ),
                Icon(
                  icon,
                  color: theme.accentColor,
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: Spacings.spacingBetweenElements,
        ),
      ],
    );
  }
}
