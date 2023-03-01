import 'package:doomi/models/database%20models/project.dart';
import 'package:doomi/providers/errors_provider.dart';
import 'package:doomi/providers/project_state_provider.dart';
import 'package:doomi/providers/theme_provider.dart';
import 'package:doomi/services/navigation_service.dart';
import 'package:doomi/utils/enums.dart';
import 'package:doomi/utils/general_functions.dart';
import 'package:doomi/utils/styles/spacings.dart';
import 'package:doomi/widgets/cta.dart';
import 'package:doomi/widgets/date_picker.dart';
import 'package:doomi/widgets/keyboard_dismisser.dart';
import 'package:doomi/widgets/password_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/bottom_sheet_field.dart';

// Used to add a new project or edit an existing one
class WriteProjectScreen extends ConsumerWidget {
  const WriteProjectScreen({
    super.key,
    this.project,
  });

  final Project? project;

  onActionPressed(ProjectStateNotifier notifier, BuildContext context,
      ErrorsNotifier errorNotifier) async {
    try {
      await notifier.onActionPressed();
      NavigatorService.pop(context);
    } on Exception catch (e, s) {
      errorNotifier.showError(e, context, s: s);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(projectStateProvider(project));
    ref.watch(projectStateProvider(project));
    final theme = ref.watch(themeProvider);
    return KeyboardDismisser(
      child: Scaffold(
        backgroundColor: theme.background,
        body: Column(
          children: [
            CupertinoTheme(
              data: CupertinoThemeData(
                primaryColor: theme.accentColor,
              ),
              child: CupertinoNavigationBar(
                backgroundColor: theme.background,
                middle: Text(
                  project == null
                      ? translate('createProject', context)
                      : translate('editProject', context),
                  style: TextStyle(color: theme.textColor),
                ),
              ),
            ),
            const SizedBox(height: Spacings.spacingFactor * 3),
            Expanded(
              child: ListView(
                padding: Spacings.horizontalPadding,
                children: [
                  CustomTextField(
                    onChanged: notifier.setProjectName,
                    initialText: notifier.title,
                    hint: translate('managementSystem', context),
                    labelAboveField: translate('projectName', context),
                  ),
                  const SizedBox(height: Spacings.spacingBetweenElements),
                  CustomTextField(
                    onChanged: notifier.setProjectDescription,
                    initialText: notifier.description,
                    hint: translate('managementSystemDesc', context),
                    labelAboveField: translate('projectDescription', context),
                  ),
                  const SizedBox(height: Spacings.spacingBetweenElements),
                  DatePicker(
                    onDateChanged: notifier.setStartingDate,
                    textAboveTextField: translate('startingDate', context),
                    initialDate: notifier.startingDate,
                  ),
                  const SizedBox(height: Spacings.spacingBetweenElements),
                  DatePicker(
                    onDateChanged: notifier.setDueDate,
                    textAboveTextField: translate('dueDate', context),
                    initialDate: notifier.dueDate,
                  ),
                  const SizedBox(height: Spacings.spacingBetweenElements),
                  Text(
                    translate('status', context),
                    style: theme.labelStyle,
                  ),
                  const SizedBox(height: Spacings.spacingFactor),
                  BottomSheetField(
                    options: ProjectStatus.values.map((e) {
                      switch (e) {
                        case ProjectStatus.active:
                          return translate('active', context);

                        case ProjectStatus.canceled:
                          return translate('canceled', context);

                        case ProjectStatus.completed:
                          return translate('done', context);

                        case ProjectStatus.archived:
                          return translate('archived', context);
                      }
                    }).toList(),
                    intialValue: () {
                      switch (notifier.status) {
                        case ProjectStatus.active:
                          return translate('active', context);

                        case ProjectStatus.archived:
                          return translate('archived', context);

                        case ProjectStatus.canceled:
                          return translate('canceled', context);
                        case ProjectStatus.completed:
                          return translate('done', context);
                      }
                    }(),
                    onOptionSelected: (String s) {
                      ProjectStatus status;

                      if (s == translate('active', context)) {
                        status = ProjectStatus.active;
                      } else if (s == translate('canceled', context)) {
                        status = ProjectStatus.canceled;
                      } else if (s == translate('done', context)) {
                        status = ProjectStatus.completed;
                      } else if (s == translate('archived', context)) {
                        status = ProjectStatus.archived;
                      } else {
                        throw Exception('Invalid case');
                      }
                      notifier.setProjectStatus(status);
                    },
                  ),
                  const SizedBox(height: Spacings.spacingBetweenElements * 2),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: Spacings.bottomScreenPadding(context).bottom,
                left: Spacings.horizontalPadding.left,
                right: Spacings.horizontalPadding.right,
              ),
              child: SizedBox(
                width: double.maxFinite,
                child: CtaButton(
                  label: project == null
                      ? translate('create', context)
                      : translate('saveChanges', context),
                  animateAsyncProcess: true,
                  onPressed: () async => await onActionPressed(
                    notifier,
                    context,
                    ref.read(errorsProvider.notifier),
                  ),
                  animateEnabledState: true,
                  enabled: notifier.isProjectValid,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
