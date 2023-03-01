import 'package:doomi/providers/errors_provider.dart';
import 'package:doomi/providers/register_screen_notifier.dart';
import 'package:doomi/providers/theme_provider.dart';
import 'package:doomi/services/navigation_service.dart';
import 'package:doomi/utils/general_functions.dart';
import 'package:doomi/utils/router.dart';
import 'package:doomi/utils/styles/spacings.dart';
import 'package:doomi/widgets/cta.dart';
import 'package:doomi/widgets/custom_text_field.dart';
import 'package:doomi/widgets/keyboard_dismisser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final notifier = ref.read(registerScreenNotifier.notifier);
    ref.watch(registerScreenNotifier);

    return Scaffold(
      backgroundColor: theme.background,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: Spacings.horizontalPadding.left,
          right: Spacings.horizontalPadding.left,
          bottom: 48,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CtaButton(
              label: translate('register', context),
              enabled: notifier.areInfofilled(),
              animateEnabledState: true,
              animateAsyncProcess: true,
              onPressed: () async {
                try {
                  await notifier.onRegisterPressed();
                  NavigatorService.navigateAndClearHistory(
                      Routes.home, context);
                } on Exception catch (e, _) {
                  ref.read(errorsProvider.notifier).showError(e, context);
                }
              },
            ),
            const SizedBox(height: Spacings.spacingBetweenElements),
            InkWell(
              onTap: () => NavigatorService.navigateTo(Routes.login, context),
              child: Padding(
                padding: const EdgeInsets.all(Spacings.spacingFactor),
                child: Text(
                  translate('alreadyHaveAnAccount', context),
                  textAlign: TextAlign.center,
                  style: theme.body2.copyWith(
                    color: theme.accentColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: KeyboardDismisser(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: Spacings.topScreenPadding(context).top,
            left: Spacings.horizontalPadding.left,
            right: Spacings.horizontalPadding.right,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/pngs/splash.png',
                height: 100,
              ),
              const SizedBox(height: Spacings.spacingBetweenElements * 2),
              CustomTextField(
                labelAboveField: translate('yourEmailAddress', context),
                hint: 'Joe@gmail.com',
                onChanged: (v) => notifier.setEmail = v,
              ),
              const SizedBox(height: Spacings.spacingBetweenElements * 1.5),
              CustomTextField(
                labelAboveField: translate('firstName', context),
                hint: translate('firstNameExample', context),
                onChanged: (v) => notifier.setFirstName = v,
              ),
              const SizedBox(height: Spacings.spacingBetweenElements * 1.5),
              CustomTextField(
                labelAboveField: translate('lastName', context),
                hint: translate('lastNameExample', context),
                onChanged: (v) => notifier.setLastName = v,
              ),
              const SizedBox(height: Spacings.spacingBetweenElements * 1.5),
              CustomTextField(
                labelAboveField: translate('yourPassword', context),
                onChanged: (v) => notifier.setPassword = v,
              ),
              const SizedBox(height: Spacings.spacingBetweenElements * 1.5),
              CustomTextField(
                labelAboveField: translate('confirmPassword', context),
                onChanged: (v) => notifier.setPasswordConfirmation = v,
              ),
              const SizedBox(height: Spacings.spacingBetweenElements * 4),
            ],
          ),
        ),
      ),
    );
  }
}
