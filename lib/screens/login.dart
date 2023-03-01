import 'package:doomi/providers/login_screen_notifier.dart';
import 'package:doomi/providers/errors_provider.dart';
import 'package:doomi/providers/theme_provider.dart';
import 'package:doomi/services/navigation_service.dart';
import 'package:doomi/utils/general_functions.dart';
import 'package:doomi/utils/router.dart';
import 'package:doomi/utils/styles/spacings.dart';
import 'package:doomi/widgets/cta.dart';
import 'package:doomi/widgets/custom_text_field.dart';
import 'package:doomi/widgets/keyboard_dismisser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final notifier = ref.read(loginScreenNotifier.notifier);
    ref.watch(loginScreenNotifier);

    return KeyboardDismisser(
      child: Scaffold(
        backgroundColor: theme.background,
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            left: Spacings.horizontalPadding.left,
            right: Spacings.horizontalPadding.left,
            bottom: Spacings.bottomScreenPadding(context).bottom,
          ),
          child: CtaButton(
            label: translate('login', context),
            enabled: notifier.areInfofilled(),
            animateEnabledState: true,
            animateAsyncProcess: true,
            onPressed: () async {
              try {
                await notifier.onLoginPressed();
                NavigatorService.navigateAndClearHistory(Routes.home, context);
              } on Exception catch (e, _) {
                ref.read(errorsProvider.notifier).showError(e, context);
              }
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: Spacings.topScreenPadding(context).top),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: SizedBox(
                  width: 44,
                  height: 44,
                  child: InkWell(
                    onTap: () => NavigatorService.pop(context),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Icon(
                      CupertinoIcons.back,
                      size: 35,
                      color: theme.accentColor,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: Spacings.horizontalPadding.left,
                    right: Spacings.horizontalPadding.right,
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/pngs/splash.png',
                        height: 100,
                      ),
                      const SizedBox(
                          height: Spacings.spacingBetweenElements * 2),
                      CustomTextField(
                        labelAboveField: translate('yourEmailAddress', context),
                        hint: 'Joe@gmail.com',
                        onChanged: (v) => notifier.setEmail = v,
                      ),
                      const SizedBox(
                          height: Spacings.spacingBetweenElements * 1.5),
                      CustomTextField(
                        labelAboveField: translate('yourPassword', context),
                        hint: 'Joe@gmail.com',
                        onChanged: (v) => notifier.setPassword = v,
                      ),
                      const SizedBox(
                          height: Spacings.spacingBetweenElements * 1.5),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
