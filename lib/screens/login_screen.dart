import 'package:doomi/utils/styles/spacings.dart';
import 'package:doomi/widgets/custom_text_field.dart';
import 'package:doomi/widgets/keyboard_dismisser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: KeyboardDismisser(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: Spacings.topScreenPadding(context).top,
            bottom: Spacings.bottomScreenPadding(context).bottom,
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
                labelAboveField: 'Your email address',
                hint: 'Joe@gmail.com',
                onChanged: (email) {},
              ),
              const SizedBox(height: Spacings.spacingBetweenElements * 1.5),
              CustomTextField(
                labelAboveField: 'Your password',
                hint: 'Joe@gmail.com',
                onChanged: (email) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
