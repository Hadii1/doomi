import 'dart:io';

import 'package:collection/collection.dart';
import 'package:doomi/models/database%20models/project.dart';
import 'package:doomi/providers/csv_converter_provider.dart';
import 'package:doomi/providers/errors_provider.dart';
import 'package:doomi/providers/locale_provider.dart';
import 'package:doomi/providers/projects_provider.dart';
import 'package:doomi/providers/theme_provider.dart';
import 'package:doomi/services/navigation_service.dart';
import 'package:doomi/utils/extensions.dart';
import 'package:doomi/utils/general_functions.dart';
import 'package:doomi/utils/router.dart';
import 'package:doomi/utils/styles/spacings.dart';
import 'package:doomi/widgets/action_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_file/open_file.dart';

class ProjectDetailsScreen extends ConsumerWidget {
  final String projectId;

  const ProjectDetailsScreen({
    required this.projectId,
    super.key,
  });

  onEditProjectPressed(BuildContext context, Project project) =>
      NavigatorService.navigateWithArg(Routes.writeProject, context, project);

  onStatusesPressed(BuildContext context, Project project) =>
      NavigatorService.navigateWithArg(
          Routes.projectStatuses, context, project);

  onCompletedTasksPressed(BuildContext context, Project project) =>
      NavigatorService.navigateWithArg(Routes.completedTasks, context, project);

  onDeleteProjectPressed(
      WidgetRef ref, BuildContext context, Project project) async {
    try {
      await ref.read(projectsProvider.notifier).deleteProject(project);
      NavigatorService.pop(context);
    } on Exception catch (e, s) {
      ref.read(errorsProvider.notifier).showError(e, context, s: s);
    }
  }

  Future<void> onExportToCsvPressed(
      WidgetRef ref, Project project, BuildContext context) async {
    try {
      File file = await ref
          .read(csvNotifierProvider(project).notifier)
          .convertProjectToCsv();
      ref.read(errorsProvider.notifier).showNotification(
          '${translate('fileSavedTo', context)}: ${file.path}');

      await OpenFile.open(file.path);
    } on Exception catch (e, s) {
      ref.read(errorsProvider.notifier).showError(
            e,
            context,
            s: s,
            reportError: false,
          );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final locale = ref.watch(localProvider);

    // We keep track of the project using the provider so
    // that if it got edited, the change would be reflected here.
    final Project? project = ref
        .watch(projectsProvider)
        .data!
        .firstWhereOrNull((e) => e.id == projectId);

    // This only happens for a few milliseconds
    // (while navigating back) in case the project was deleted.
    if (project == null) return const Scaffold();

    return Scaffold(
      backgroundColor: theme.background,
      body: Column(
        children: [
          CupertinoNavigationBar(
            backgroundColor: theme.background,
            middle: Text(
              project.title,
              style: TextStyle(color: theme.textColor),
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
                      Text(
                        translate('description', context).toUpperCase(),
                        style: theme.labelStyle,
                      ),
                      const SizedBox(
                        height: Spacings.spacingFactor,
                      ),
                      Text(
                        project.description,
                        style: theme.body2,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: Spacings.spacingBetweenElements,
                ),
                Container(
                  padding: const EdgeInsets.all(Spacings.spacingFactor * 2),
                  decoration: BoxDecoration(
                    color: theme.backgroundLightContrast,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                project.startingDate.getReadableDate(locale),
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
                                project.dueDate.getReadableDate(locale),
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
                ActionTile(
                    label: translate('statusesAndTasks', context),
                    icon: CupertinoIcons.list_bullet,
                    onTap: () => onStatusesPressed(context, project)),
                ActionTile(
                    label: translate('completedTasks', context),
                    icon: CupertinoIcons.check_mark,
                    onTap: () => onCompletedTasksPressed(context, project)),
                ActionTile(
                  label: translate('editProjectInfo', context),
                  icon: CupertinoIcons.pen,
                  onTap: () => onEditProjectPressed(context, project),
                ),
                ActionTile(
                  label: translate('deleteProject', context),
                  icon: CupertinoIcons.delete,
                  animatedLoading: true,
                  onTap: () async =>
                      await onDeleteProjectPressed(ref, context, project),
                ),
                ActionTile(
                  label: translate('exportToCsv', context),
                  icon: CupertinoIcons.share,
                  animatedLoading: true,
                  onTap: () async {
                    await onExportToCsvPressed(ref, project, context);
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
