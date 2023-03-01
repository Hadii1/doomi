import 'package:doomi/models/database%20models/status.dart';
import 'package:doomi/models/database%20models/task.dart';
import 'package:doomi/providers/tasks_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskProviderArg {
  final String project;
  final Status status;
  final Task? task;

  TaskProviderArg({
    required this.project,
    required this.status,
    this.task,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TaskProviderArg &&
        other.project == project &&
        other.status == status &&
        other.task == task;
  }

  @override
  int get hashCode => project.hashCode ^ status.hashCode ^ task.hashCode;
}

final taskStateProvider = ChangeNotifierProvider.autoDispose.family(
  (ref, TaskProviderArg arg) => TaskStateNotifier(
    task: arg.task,
    status: arg.status,
    projectId: arg.project,
    tasksNotifier: ref.read(tasksProvider(arg.project).notifier),
  ),
);

class TaskStateNotifier extends ChangeNotifier {
  late String title;
  late String description;
  late DateTime startDate;
  late DateTime dueDate;

  final Task? task;
  final Status status;

  final String projectId;

  final TasksNotifier tasksNotifier;

  TaskStateNotifier({
    this.task,
    required this.tasksNotifier,
    required this.status,
    required this.projectId,
  }) {
    title = task?.title ?? '';
    description = task?.description ?? '';
    startDate = task?.startingDate ?? DateTime.now();
    dueDate = task?.dueDate ??
        DateTime.now().add(
          const Duration(days: 7),
        );
  }

  void setTaskName(String name) {
    title = name.trim();
    notifyListeners();
  }

  void setTaskDescription(String desc) {
    description = desc.trim();
    notifyListeners();
  }

  void setStartingDate(DateTime d) {
    startDate = d;
    notifyListeners();
  }

  void setDueDate(DateTime d) {
    dueDate = d;
    notifyListeners();
  }

  bool get isTaskValid {
    if (task != null) {
      if (didInfoChange == false) return false;
    }
    return title.isNotEmpty && description.isNotEmpty;
  }

  // Used in case if editing an existing status to
  // check if data has been edited
  bool get didInfoChange {
    if (task == null) return true;
    return title != task!.title ||
        description != task!.description ||
        startDate != task!.startingDate ||
        dueDate != task!.dueDate;
  }

  Future<void> onActionPressed() async {
    if (task == null) {
      Task task = Task(
        id: '',
        title: title,
        istrackingTime: false,
        description: description,
        statusId: status.id,
        projectID: projectId,
        dueDate: dueDate,
        timeSpent: const Duration(seconds: 0),
        startingDate: startDate,
      );

      tasksNotifier.addTask(task);
    } else {
      Task updated = Task(
        id: task!.id,
        statusId: task!.statusId,
        timeSpent: task!.timeSpent,
        projectID: task!.projectID,
        istrackingTime: task!.istrackingTime,
        description: description,
        dueDate: dueDate,
        startingDate: startDate,
        title: title,
      );

      tasksNotifier.editTask(updated);
    }
  }
}
