import 'package:doomi/models/database%20models/project.dart';
import 'package:doomi/models/database%20models/status.dart';
import 'package:doomi/providers/errors_provider.dart';
import 'package:doomi/providers/status_state_provider.dart';
import 'package:doomi/providers/statuses_provider.dart';
import 'package:doomi/providers/theme_provider.dart';
import 'package:doomi/services/navigation_service.dart';
import 'package:doomi/utils/general_functions.dart';
import 'package:doomi/utils/styles/spacings.dart';
import 'package:doomi/widgets/cta.dart';
import 'package:doomi/widgets/keyboard_dismisser.dart';
import 'package:doomi/widgets/password_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Used to add a new status or edit an existing one
class WriteStatus extends ConsumerWidget {
  const WriteStatus({
    super.key,
    required this.project,
    this.status,
  });

  final Project project;
  final Status? status;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final notifier = ref.watch(statusStateProvider(
        StatusProviderArg(project: project, status: status)));
    ref.watch(statusStateProvider(
        StatusProviderArg(project: project, status: status)));

    return Container(
      color: theme.background,
      child: KeyboardDismisser(
        child: Padding(
          padding: const EdgeInsets.all(Spacings.spacingFactor * 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  status == null
                      ? translate('createStatus', context)
                      : translate('editStatus', context),
                  style: theme.title1,
                ),
              ),
              const SizedBox(height: Spacings.spacingBetweenElements),
              CustomTextField(
                  onChanged: notifier.setStatusName,
                  initialText: notifier.title,
                  labelAboveField: translate('statusName', context),
                  hint: translate('todo', context)),
              const SizedBox(height: Spacings.spacingBetweenElements),
              CustomTextField(
                onChanged: notifier.setStatusDescription,
                initialText: notifier.description,
                labelAboveField: translate('statusDescription', context),
                hint: translate('pendingTasksGoesHere', context),
              ),
              const SizedBox(
                height: Spacings.spacingBetweenElements * 2,
              ),
              if (status != null)
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    onDeletePressed(ref, context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: Spacings.spacingBetweenElements * 2,
                    ),
                    child: Text(
                      translate('deleteStatus', context),
                      style: theme.body3.copyWith(
                        color: theme.accentColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              CtaButton(
                label: status == null
                    ? translate('createStatus', context)
                    : translate('saveChanges', context),
                onPressed: () async {
                  try {
                    await notifier.onActionPressed();
                    NavigatorService.pop(context);
                  } on Exception catch (e, s) {
                    ref
                        .read(errorsProvider.notifier)
                        .showError(e, context, s: s);
                  }
                },
                animateEnabledState: true,
                enabled: notifier.isStatusValid,
              ),
              SizedBox(
                height: MediaQuery.of(context).viewInsets.bottom + 24,
              )
            ],
          ),
        ),
      ),
    );
  }

  void onDeletePressed(WidgetRef ref, BuildContext context) {
    try {
      ref.read(statusesProvider(project.id).notifier).deleteStatus(status!);
      NavigatorService.pop(context);
    } on Exception catch (e, s) {
      ref.read(errorsProvider.notifier).showError(e, context, s: s);
    }
  }
}
