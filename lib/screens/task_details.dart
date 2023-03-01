import 'package:collection/collection.dart';
import 'package:doomi/models/database%20models/status.dart';
import 'package:doomi/models/database%20models/task.dart';
import 'package:doomi/providers/errors_provider.dart';
import 'package:doomi/providers/locale_provider.dart';
import 'package:doomi/providers/statuses_provider.dart';
import 'package:doomi/providers/tasks_provider.dart';
import 'package:doomi/providers/theme_provider.dart';
import 'package:doomi/providers/time_tracker_provider.dart';
import 'package:doomi/services/navigation_service.dart';
import 'package:doomi/utils/extensions.dart';
import 'package:doomi/utils/general_functions.dart';
import 'package:doomi/utils/styles/spacings.dart';
import 'package:doomi/widgets/action_tile.dart';
import 'package:doomi/widgets/bottom_sheet_field.dart';
import 'package:doomi/widgets/write_task_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskDetailsScreenArg {
  final Task task;
  final Status status;

  TaskDetailsScreenArg(this.task, this.status);
}

class TaskDetailsScreen extends ConsumerWidget {
  final TaskDetailsScreenArg arg;

  const TaskDetailsScreen({
    required this.arg,
    super.key,
  });

  void onEditPressed(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => WriteTask(
        project: arg.task.projectID,
        status: arg.status,
        task: arg.task,
      ),
    );
  }

  Future<void> onChangeStatusPressed(
      WidgetRef ref, String statusName, BuildContext context) async {
    Status status = ref
        .watch(statusesProvider(arg.task.projectID))
        .data!
        .firstWhere((e) => e.title == statusName);
    Task updated = arg.task.changeStatus(status.id);
    try {
      await ref
          .read(tasksProvider(arg.task.projectID).notifier)
          .editTask(updated);
    } on Exception catch (e, s) {
      ref.read(errorsProvider.notifier).showError(e, context, s: s);
    }
  }

  Future<void> onMarkTaskAsCompletedPressed(
      WidgetRef ref, BuildContext context) async {
    Task updated = arg.task.markAsCompleted();
    try {
      await ref
          .read(tasksProvider(arg.task.projectID).notifier)
          .editTask(updated);
      NavigatorService.pop(context);
    } on Exception catch (e, s) {
      ref.read(errorsProvider.notifier).showError(e, context, s: s);
    }
  }

  Future<void> onDeleteTaskPressed(WidgetRef ref, BuildContext context) async {
    await ref
        .read(tasksProvider(arg.task.projectID).notifier)
        .deleteTask(arg.task);
    NavigatorService.pop(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final locale = ref.watch(localProvider);

    // final timingState = ref.watch(timeTrackerProvider(this.task));

    Task task = ref
            .watch(tasksProvider(arg.task.projectID))
            .data
            ?.firstWhereOrNull((e) => e.id == arg.task.id) ??
        arg.task;

    return Scaffold(
      backgroundColor: theme.background,
      body: Column(
        children: [
          CupertinoTheme(
            data: CupertinoThemeData(
              primaryColor: theme.accentColor,
            ),
            child: CupertinoNavigationBar(
              backgroundColor: theme.background,
              previousPageTitle: translate('home', context),
              middle: Text(
                task.title,
                style: TextStyle(color: theme.textColor),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(
                vertical: Spacings.spacingFactor * 3,
                horizontal: Spacings.horizontalPadding.left,
              ),
              children: [
                Container(
                  padding: const EdgeInsets.all(Spacings.spacingFactor * 2),
                  decoration: BoxDecoration(
                    color: theme.backgroundLightContrast,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  translate('description', context)
                                      .toUpperCase(),
                                  style: theme.labelStyle,
                                ),
                                const SizedBox(
                                  height: Spacings.spacingFactor,
                                ),
                                Text(
                                  task.description,
                                  style: theme.body2,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: Spacings.spacingFactor * 2,
                          ),
                          Align(
                            alignment: AlignmentDirectional.topEnd,
                            child: Material(
                              type: MaterialType.transparency,
                              child: InkWell(
                                onTap: () => onEditPressed(context),
                                child: const Icon(CupertinoIcons.pen),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: Spacings.spacingBetweenElements,
                      ),
                      Text(
                        translate('dates', context).toUpperCase(),
                        style: theme.labelStyle,
                      ),
                      const SizedBox(
                        height: Spacings.spacingFactor,
                      ),
                      Row(
                        children: [
                          Text(
                            '${translate('startingDate', context)}:  ',
                            style: theme.body2.copyWith(
                                color: theme.textColor.withOpacity(0.7)),
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
                        height: Spacings.spacingFactor / 2,
                      ),
                      Row(
                        children: [
                          Text(
                            '${translate('dueDate', context)}:  ',
                            style: theme.body2.copyWith(
                                color: theme.textColor.withOpacity(0.7)),
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
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: Spacings.spacingBetweenElements,
                ),
                TimingCard(task: task),
                const SizedBox(
                  height: Spacings.spacingBetweenElements,
                ),
                BottomSheetField(
                  prefixText: translate('status', context),
                  options: ref
                      .watch(statusesProvider(task.projectID))
                      .data!
                      .map((e) => e.title)
                      .toList(),
                  intialValue: ref
                      .watch(statusesProvider(task.projectID))
                      .data!
                      .firstWhere((e) => e.id == task.statusId)
                      .title,
                  onOptionSelected: (String name) async =>
                      await onChangeStatusPressed(ref, name, context),
                  fillColor: theme.backgroundLightContrast,
                  boxBorder: Border.all(
                    width: 0,
                    color: Colors.transparent,
                  ),
                  borderRadius: 8,
                  verticalPadding: 2,
                ),
                const SizedBox(
                  height: Spacings.spacingBetweenElements,
                ),
                ActionTile(
                  label: translate('markTaskAsCompleted', context),
                  icon: Icons.check,
                  animatedLoading: true,
                  onTap: () async =>
                      await onMarkTaskAsCompletedPressed(ref, context),
                ),
                ActionTile(
                  label: translate('deleteTask', context),
                  animatedLoading: true,
                  icon: CupertinoIcons.delete,
                  onTap: () async {
                    await onDeleteTaskPressed(ref, context);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

@visibleForTesting
class TimingCard extends ConsumerWidget {
  const TimingCard({
    required this.task,
    super.key,
  });

  final Task task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Task task = ref
            .watch(tasksProvider(this.task.projectID))
            .data!
            .firstWhereOrNull((e) => e.id == this.task.id) ??
        this.task;

    final timingState = ref.watch(timeTrackerProvider(task));
    final theme = ref.watch(themeProvider);

    return Container(
      padding: const EdgeInsets.all(Spacings.spacingFactor * 2),
      decoration: BoxDecoration(
        color: theme.backgroundLightContrast,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            translate('timings', context).toUpperCase(),
            style: theme.labelStyle,
          ),
          const SizedBox(
            height: Spacings.spacingFactor,
          ),
          Text(
            '${translate('totalTimeSpent', context)}: ${timingState.timeSpent.toString().split('.').first.padLeft(8, "0")}',
            style:
                theme.body2.copyWith(color: theme.textColor.withOpacity(0.7)),
          ),
          const SizedBox(
            height: Spacings.spacingFactor,
          ),
          TextButton(
            onPressed: () {
              if (task.istrackingTime) {
                timingState.stopTracking();
              } else {
                timingState.startTracking();
              }
            },
            style: TextButton.styleFrom(
              backgroundColor: task.istrackingTime ? Colors.red : Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                // side: BorderSide(width: 0.5, color: theme.accentColor),
              ),
            ),
            child: Text(
              task.istrackingTime
                  ? translate('stopTracking', context)
                  : translate('startTracking', context),
              style: theme.body1.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
