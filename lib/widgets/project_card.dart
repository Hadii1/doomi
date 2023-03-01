import 'package:doomi/models/database%20models/project.dart';
import 'package:doomi/providers/locale_provider.dart';
import 'package:doomi/providers/theme_provider.dart';
import 'package:doomi/services/navigation_service.dart';
import 'package:doomi/utils/enums.dart';
import 'package:doomi/utils/extensions.dart';
import 'package:doomi/utils/general_functions.dart';
import 'package:doomi/utils/router.dart';
import 'package:doomi/utils/styles/spacings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProjectCard extends ConsumerWidget {
  const ProjectCard({
    super.key,
    required this.project,
  });

  final Project project;

  String getStatusText(BuildContext context, ProjectStatus status) {
    switch (status) {
      case ProjectStatus.active:
        return translate('active', context);
      case ProjectStatus.archived:
        return translate('archived', context);

      case ProjectStatus.canceled:
        return translate('canceled', context);

      case ProjectStatus.completed:
        return translate('done', context);
    }
  }

  Color getStatusColor(ProjectStatus status) {
    switch (status) {
      case ProjectStatus.active:
        return Colors.blue;
      case ProjectStatus.archived:
        return Colors.grey;
      case ProjectStatus.canceled:
        return Colors.red;
      case ProjectStatus.completed:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final locale = ref.watch(localProvider);
    return InkWell(
      onTap: () => NavigatorService.navigateWithArg(
          Routes.projectDetails, context, project.id),
      child: Container(
        padding: const EdgeInsets.all(Spacings.spacingFactor * 2),
        decoration: BoxDecoration(
          // color: theme.backgroundLightContrast,
          color: theme.backgroundLightContrast,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              project.title,
              style: theme.title1,
              maxLines: 3,
            ),
            const SizedBox(height: Spacings.spacingBetweenElements),
            Text(
              project.description,
              style: theme.body3,
            ),
            const SizedBox(height: Spacings.spacingBetweenElements),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                      project.startingDate.getReadableDate(locale),
                      style: theme.body2,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: Spacings.spacingFactor),
            Row(
              children: [
                Text(
                  '${translate('due', context)}:  ',
                  style: theme.hintStyle,
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
                ),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: getStatusColor(project.status),
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  getStatusText(context, project.status).toUpperCase(),
                  style: theme.labelStyle.copyWith(fontSize: 13),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
