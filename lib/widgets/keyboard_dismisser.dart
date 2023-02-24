import 'package:flutter/material.dart';

// This is usually wrapped around screens
// so that the user can tap anywhere to
// hide the keyboard and unfocus from
// a specific textfield.
class KeyboardDismisser extends StatelessWidget {
  const KeyboardDismisser({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode node = FocusScope.of(context);
        if (!node.hasPrimaryFocus) {
          node.unfocus();
        }
      },
      child: child,
    );
  }
}
