import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:doomi/models/database%20models/project.dart';
import 'package:doomi/models/database%20models/status.dart';
import 'package:doomi/models/database%20models/task.dart';
import 'package:doomi/providers/statuses_provider.dart';
import 'package:doomi/providers/tasks_provider.dart';
import 'package:doomi/providers/theme_provider.dart';
import 'package:doomi/utils/enums.dart';
import 'package:doomi/utils/general_functions.dart';
import 'package:doomi/utils/styles/spacings.dart';
import 'package:doomi/widgets/error_widget.dart';
import 'package:doomi/widgets/loader.dart';
import 'package:doomi/widgets/task_card.dart';
import 'package:doomi/widgets/write_status_bottom_sheet.dart';
import 'package:doomi/widgets/write_task_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProjectStatuses extends ConsumerStatefulWidget {
  const ProjectStatuses({
    required this.project,
    super.key,
  });

  final Project project;

  @override
  ConsumerState<ProjectStatuses> createState() => _ProjectStatusesState();
}

class _ProjectStatusesState extends ConsumerState<ProjectStatuses> {
  int activeStatus = 0;

  onAddStatusPressed() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => WriteStatus(project: widget.project),
    );
  }

  onAddTaskPressed(Status status) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => WriteTask(
        project: widget.project.id,
        status: status,
      ),
    );
  }

  onEditStatusPresed(Status status) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => WriteStatus(
        project: widget.project,
        status: status,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);
    final statuses = ref.watch(statusesProvider(widget.project.id));
    final tasks = ref.watch(tasksProvider(widget.project.id));

    return Scaffold(
      backgroundColor: theme.background,
      appBar: CupertinoNavigationBar(
        backgroundColor: theme.background,
        previousPageTitle: "",
        trailing: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onAddStatusPressed,
            child: const Icon(
              CupertinoIcons.add,
              size: 28,
            ),
          ),
        ),
        middle: Text(widget.project.title),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: statuses.status == NetworkCallStatus.loading ||
                tasks.status == NetworkCallStatus.loading
            ? const Loader()
            : statuses.status == NetworkCallStatus.error ||
                    tasks.status == NetworkCallStatus.error
                ? CustomErrorWidget(onActionPressed: () {
                    if (statuses.status == NetworkCallStatus.error) {
                      ref.invalidate(statusesProvider(widget.project.id));
                    }

                    if (tasks.status == NetworkCallStatus.error) {
                      ref.invalidate(tasksProvider(widget.project.id));
                    }
                  })
                : statuses.data!.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            translate('noStatusesAdded', context),
                            style: theme.title2,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: Spacings.spacingBetweenElements,
                          ),
                          Text(
                            translate('addStatusByPressingPlus', context),
                            style: theme.body3,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: Spacings.spacingFactor * 8,
                          )
                        ],
                      )
                    : DefaultTabController(
                        length: statuses.data!.length,
                        child: Column(
                          children: [
                            TabBar(
                              isScrollable: true,
                              onTap: (value) {
                                activeStatus = value;
                                setState(() {});
                              },
                              dividerColor: theme.accentColor,
                              indicatorColor: theme.accentColor,
                              indicatorPadding:
                                  const EdgeInsets.only(bottom: 2),
                              labelPadding: const EdgeInsets.symmetric(
                                  horizontal: Spacings.spacingFactor),
                              tabs: statuses.data!
                                  .map(
                                    (e) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: Spacings.spacingFactor * 2,
                                          horizontal:
                                              Spacings.spacingFactor * 3),
                                      child: Row(
                                        children: [
                                          Text(
                                            e.title,
                                            style: theme.body2,
                                          ),
                                          AnimatedSizeAndFade(
                                            child: activeStatus ==
                                                    statuses.data!.length
                                                ? const SizedBox.shrink()
                                                : statuses.data![
                                                            activeStatus] ==
                                                        e
                                                    ? InkWell(
                                                        onTap: () =>
                                                            onEditStatusPresed(
                                                                e),
                                                        splashColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        child: SizedBox(
                                                          width: 44,
                                                          child: Align(
                                                            alignment:
                                                                AlignmentDirectional
                                                                    .centerEnd,
                                                            child: Icon(
                                                              CupertinoIcons
                                                                  .pen,
                                                              color: theme
                                                                  .accentColor,
                                                              size: 21,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : const SizedBox.shrink(),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                            Expanded(
                              child: TabBarView(
                                children: statuses.data!.map(
                                  (e) {
                                    List<Task> statusTasks = tasks.data!
                                        .where((t) => t.statusId == e.id)
                                        .toList();
                                    statusTasks.removeWhere(
                                        (e) => e.dateCompleted != null);
                                    return Stack(
                                      alignment: AlignmentDirectional.bottomEnd,
                                      children: [
                                        ListView.builder(
                                          padding: const EdgeInsets.all(
                                            Spacings.spacingFactor * 2,
                                          ),
                                          itemCount: statusTasks.length,
                                          itemBuilder: (context, index) =>
                                              Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: Spacings
                                                    .spacingBetweenElements),
                                            child: TaskCard(
                                              task: statusTasks[index],
                                              status: e,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional.only(
                                            bottom: MediaQuery.of(context)
                                                .padding
                                                .bottom,
                                            end: Spacings.spacingFactor * 3,
                                          ),
                                          child: FloatingActionButton(
                                            backgroundColor: theme.accentColor,
                                            child:
                                                const Icon(CupertinoIcons.add),
                                            onPressed: () =>
                                                onAddTaskPressed(e),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                ).toList(),
                              ),
                            )
                          ],
                        ),
                      ),
      ),
    );
  }
}
