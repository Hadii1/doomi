import 'package:doomi/interfaces/online_storage.dart';
import 'package:doomi/models/response.dart';
import 'package:doomi/models/database%20models/task.dart';
import 'package:doomi/providers/errors_provider.dart';
import 'package:doomi/providers/online_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tasksProvider = StateNotifierProvider.family
    .autoDispose<TasksNotifier, Response<List<Task>>, String>(
  (ref, String project) => TasksNotifier(
    project: project,
    db: ref.read(onlineStorageProvider),
    errorsNotifier: ref.read(errorsProvider.notifier),
  ),
);

class TasksNotifier extends StateNotifier<Response<List<Task>>> {
  final IOnlineStorage db;
  final ErrorsNotifier errorsNotifier;
  final String project;

  TasksNotifier({
    required this.project,
    required this.errorsNotifier,
    required this.db,
    List<Task>? testList,
  }) : super(testList == null
            ? Response.loading()
            : Response.completed(testList)) {
    // if (testList == null) {
    if (testList == null) _init();
    // }
  }

  Future<void> _init() async {
    try {
      List<Task> tasks = await getTasks();
      if (mounted) state = Response.completed(tasks);
    } on Exception catch (e, s) {
      state = Response.error(e: e);
      errorsNotifier.recordError(e, s: s);
    }
  }

  Future<List<Task>> getTasks() async => await db.getProjectTasks(project);

  void addTask(Task task) async {
    Task updated = await db.addTask(task);
    state = Response.completed([...state.data!, updated]);
  }

  Future<void> deleteTask(Task t) async {
    await db.deleteTask(t.id);
    List<Task> updated = List.from(state.data!);
    updated.remove(t);
    state = Response.completed(updated);
  }

  Future<void> editTask(Task edited) async {
    await db.updateTask(edited);
    List<Task> updated = List.from(state.data!);
    // Project equality depends on the id only
    // so we can safely filter by equality here
    int index = updated.indexOf(edited);
    if (index != -1) {
      updated[index] = edited;
      state = Response.completed(updated);
    }
  }
}
