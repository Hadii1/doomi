import 'package:doomi/providers/theme_provider.dart';
import 'package:doomi/utils/styles/spacings.dart';
import 'package:doomi/widgets/cta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomErrorWidget extends ConsumerWidget {
  const CustomErrorWidget({
    Key? key,
    required this.onActionPressed,
    this.onCancel,
    this.actionText = 'Try again',
    this.errorText = 'Apologies,\nsomething went wrong.',
    // this.showCancelOption = true,
    this.fontSize = 19,
    this.bottomPadding = 72,
    this.buttonHorizontalPadding,
  }) : super(key: key);

  final Function() onActionPressed;
  final Function()? onCancel;
  // final bool showCancelOption;
  final String errorText;
  final String actionText;
  final double fontSize;
  final double bottomPadding;
  final double? buttonHorizontalPadding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          errorText,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fontSize,
            color: theme.textColor,
            fontWeight: FontWeight.w400,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: Spacings.spacingFactor * 3,
            horizontal: buttonHorizontalPadding != null
                ? buttonHorizontalPadding!
                : MediaQuery.of(context).size.width * 0.25,
          ),
          child: CtaButton(
            label: actionText,
            elevate: true,
            onPressed: onActionPressed,
            textSize: fontSize,
            height: fontSize * 2.7,
          ),
        ),
        // showCancelOption
        //     ? InkWell(
        //         splashColor: Colors.transparent,
        //         highlightColor: Colors.transparent,
        //         onTap: onCancel,
        //         child: Text(
        //           translate('cancel', context),
        //           textAlign: TextAlign.center,
        //           style: const TextStyle(
        //             fontSize: 15,
        //             color: Colors.white,
        //             decoration: TextDecoration.underline,
        //           ),
        //         ),
        //       )
        //     : const SizedBox.shrink(),
        SizedBox(
          height: bottomPadding,
        ),
      ],
    );
  }
}
