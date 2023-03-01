import 'package:doomi/models/database%20models/project.dart';
import 'package:doomi/models/database%20models/task.dart';
import 'package:doomi/providers/locale_provider.dart';
import 'package:doomi/providers/tasks_provider.dart';
import 'package:doomi/providers/theme_provider.dart';
import 'package:doomi/utils/enums.dart';
import 'package:doomi/utils/extensions.dart';
import 'package:doomi/utils/general_functions.dart';
import 'package:doomi/utils/styles/spacings.dart';
import 'package:doomi/widgets/error_widget.dart';
import 'package:doomi/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CompletedTasksScreen extends ConsumerWidget {
  final Project project;
  const CompletedTasksScreen({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final tasks = ref.watch(tasksProvider(project.id));
    return Scaffold(
      backgroundColor: theme.background,
      appBar: CupertinoNavigationBar(
        backgroundColor: theme.background,
        previousPageTitle: project.title,
        middle: Text(
          translate('completedTasks', context),
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: tasks.status == NetworkCallStatus.loading
            ? const Loader()
            : tasks.status == NetworkCallStatus.error
                ? CustomErrorWidget(
                    onActionPressed: () {
                      if (tasks.status == NetworkCallStatus.error) {
                        ref.invalidate(tasksProvider(project.id));
                      }
                    },
                  )
                : tasks.data!.where((e) => e.dateCompleted != null).isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            translate('noTasksCompletedYet', context),
                            style: theme.title2,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                    : ListView.builder(
                        padding:
                            const EdgeInsets.all(Spacings.spacingFactor * 2),
                        itemCount: tasks.data!
                            .where((e) => e.dateCompleted != null)
                            .length,
                        itemBuilder: (context, index) {
                          Task task = tasks.data!
                              .where((e) => e.dateCompleted != null)
                              .toList()[index];
                          return Padding(
                            padding: const EdgeInsets.only(
                                bottom: Spacings.spacingBetweenElements),
                            child: Container(
                              padding: const EdgeInsets.all(
                                  Spacings.spacingFactor * 2),
                              decoration: BoxDecoration(
                                color: theme.backgroundLightContrast,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    task.title,
                                    style: theme.title1,
                                  ),
                                  const SizedBox(
                                    height: Spacings.spacingFactor,
                                  ),
                                  Text(
                                    task.description,
                                    style: theme.body2,
                                  ),
                                  const SizedBox(
                                    height: Spacings.spacingFactor * 1.5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        translate('completedOn', context),
                                        style: theme.body2,
                                      ),
                                      Text(
                                        task.dateCompleted!.getReadableDate(
                                            ref.watch(localProvider)),
                                        style: theme.body2.copyWith(
                                          color: theme.accentColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: Spacings.spacingFactor / 2,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        translate('timeSpent', context),
                                        style: theme.body2,
                                      ),
                                      Text(
                                        task.timeSpent
                                            .toString()
                                            .split('.')
                                            .first
                                            .padLeft(8, "0"),
                                        style: theme.body2.copyWith(
                                          color: theme.accentColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
      ),
    );
  }
}
