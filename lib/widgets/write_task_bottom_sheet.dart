import 'package:doomi/models/database%20models/status.dart';
import 'package:doomi/models/database%20models/task.dart';
import 'package:doomi/providers/errors_provider.dart';
import 'package:doomi/providers/task_state_provider.dart';
import 'package:doomi/providers/theme_provider.dart';
import 'package:doomi/services/navigation_service.dart';
import 'package:doomi/utils/general_functions.dart';
import 'package:doomi/utils/styles/spacings.dart';
import 'package:doomi/widgets/cta.dart';
import 'package:doomi/widgets/date_picker.dart';
import 'package:doomi/widgets/keyboard_dismisser.dart';
import 'package:doomi/widgets/password_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Used to add a new task or edit an existing one
class WriteTask extends ConsumerWidget {
  const WriteTask({
    super.key,
    required this.project,
    required this.status,
    this.task,
  });

  final String project;
  final Status status;
  final Task? task; // Null if we're editing

  Future<void> onActionPressed(
      TaskStateNotifier notifier, BuildContext context, WidgetRef ref) async {
    try {
      await notifier.onActionPressed();
      NavigatorService.pop(context);
    } on Exception catch (e, s) {
      ref.read(errorsProvider.notifier).showError(
            e,
            context,
            s: s,
          );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final arg = TaskProviderArg(
      project: project,
      status: status,
      task: task,
    );

    final notifier = ref.watch(taskStateProvider(arg));

    ref.watch(taskStateProvider(arg));

    return Container(
      color: theme.background,
      child: KeyboardDismisser(
        child: Scaffold(
          backgroundColor: theme.background,
          body: Column(
            children: [
              SizedBox(
                  height: Spacings.topScreenPadding(context).top +
                      Spacings.spacingFactor * 3),
              CupertinoNavigationBar(
                automaticallyImplyLeading: false,
                backgroundColor: theme.background,
                middle: Text(
                  task == null
                      ? translate('createTask', context)
                      : translate('editTask', context),
                ),
                trailing: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    onTap: () => NavigatorService.pop(context),
                    child: const Icon(
                      Icons.close,
                      size: 28,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: Spacings.horizontalPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: Spacings.spacingBetweenElements),
                        CustomTextField(
                            onChanged: notifier.setTaskName,
                            initialText: notifier.title,
                            labelAboveField: translate('taskName', context),
                            hint: translate('wireframing', context)),
                        const SizedBox(height: Spacings.spacingBetweenElements),
                        CustomTextField(
                            onChanged: notifier.setTaskDescription,
                            initialText: notifier.description,
                            labelAboveField:
                                translate('taskDescription', context),
                            hint: translate(
                                'completeWireframeOfTheProject', context)),
                        const SizedBox(
                          height: Spacings.spacingBetweenElements,
                        ),
                        DatePicker(
                          onDateChanged: notifier.setStartingDate,
                          textAboveTextField:
                              translate('startingDate', context),
                          initialDate: notifier.startDate,
                        ),
                        const SizedBox(height: Spacings.spacingBetweenElements),
                        DatePicker(
                          onDateChanged: notifier.setDueDate,
                          textAboveTextField: translate('dueDate', context),
                          initialDate: notifier.dueDate,
                        ),
                        const SizedBox(
                            height: Spacings.spacingBetweenElements * 2),
                        CtaButton(
                          label: task == null
                              ? translate('createTask', context)
                              : translate('editTask', context),
                          onPressed: () async {
                            await onActionPressed(notifier, context, ref);
                          },
                          animateEnabledState: true,
                          animateAsyncProcess: true,
                          enabled: notifier.isTaskValid,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).viewInsets.bottom,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
