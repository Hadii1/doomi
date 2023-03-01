import 'package:doomi/models/database%20models/status.dart';
import 'package:doomi/models/database%20models/task.dart';
import 'package:doomi/providers/locale_provider.dart';
import 'package:doomi/providers/theme_provider.dart';
import 'package:doomi/screens/task_details.dart';
import 'package:doomi/services/navigation_service.dart';
import 'package:doomi/utils/extensions.dart';
import 'package:doomi/utils/general_functions.dart';
import 'package:doomi/utils/router.dart';
import 'package:doomi/utils/styles/spacings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskCard extends ConsumerWidget {
  const TaskCard({
    super.key,
    required this.task,
    required this.status,
  });

  final Task task;
  final Status status;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final locale = ref.watch(localProvider);

    return InkWell(
      onTap: () => NavigatorService.navigateWithArg(
          Routes.taskDetails, context, TaskDetailsScreenArg(task, status)),
      child: Container(
        padding: const EdgeInsets.all(Spacings.spacingFactor * 2),
        decoration: BoxDecoration(
          color: theme.backgroundLightContrast,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              task.title,
              style: theme.title1,
              maxLines: 3,
            ),
            const SizedBox(height: Spacings.spacingFactor),
            Text(
              task.description,
              style: theme.body3
                  .copyWith(color: theme.textColor.withOpacity(0.65)),
            ),
            const SizedBox(height: Spacings.spacingBetweenElements),
            // const SizedBox(height: Spacings.spacingFactor),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Text(
                      '${translate('start', context)}:  ',
                      style: theme.hintStyle,
                    ),
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          task.startingDate.getReadableDate(locale),
                          style: theme.body2,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: Spacings.spacingFactor,
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          '${translate('due', context)}:  ',
                          style: theme.hintStyle,
                        ),
                      ],
                    ),
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          task.dueDate.getReadableDate(locale),
                          style: theme.body2,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// class TaskStatusWidget extends ConsumerWidget {
//   const TaskStatusWidget({
//     super.key,
//     required this.task,
//   });

//   final Task task;

  
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final theme = ref.watch(themeProvider);
//     return Row(
//       children: [
//         // Container(
//         //   width: 10,
//         //   height: 10,
//         //   decoration: BoxDecoration(
//         //     shape: BoxShape.circle,
//         //     color: getStatusColor(),
//         //   ),
//         // ),
//         // const SizedBox(width: 4),
//         Text(
//           getStatusText(context).toUpperCase(),
//           style: theme.labelStyle.copyWith(fontSize: 13),
//         ),
//       ],
//     );
//   }
// }
