import 'package:doomi/providers/theme_provider.dart';
import 'package:doomi/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BackArrow extends ConsumerWidget {
  const BackArrow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () => NavigatorService.pop(context),
        child: Icon(
          Icons.arrow_back_ios,
          size: 24,
          color: theme.textColor,
        ),
      ),
    );
  }
}
