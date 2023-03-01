import 'package:doomi/models/custom_notification.dart';
import 'package:doomi/providers/errors_provider.dart';
import 'package:doomi/providers/theme_provider.dart';
import 'package:doomi/widgets/slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Consumer(
        builder: (_, ref, __) {
          final theme = ref.watch(themeProvider);
          CustomNotification? notification = ref.watch(errorsProvider);
          // Null state refers to initial state with no notification to show/hide
          if (notification == null) {
            return const SizedBox.shrink();
          } else {
            return AnimatedOpacity(
              opacity: notification.hide ? 0 : 1,
              duration: const Duration(milliseconds: 350),
              child: SlideAnimation(
                duration: const Duration(milliseconds: 300),
                hide: notification.hide,
                child: GestureDetector(
                  onVerticalDragUpdate: (details) {
                    if (details.delta.dy.isNegative) {
                      ref.read(errorsProvider.notifier).hide();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 48,
                    ),
                    child: Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: notification.useErrorColor
                            ? theme.accentColor
                            : Colors.green,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0.5, 2.5),
                            color: Colors.black.withOpacity(0.2),
                          )
                        ],
                      ),
                      child: Text(
                        notification.message,
                        style: theme.body3,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
