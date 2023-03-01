import 'package:doomi/interfaces/online_storage.dart';
import 'package:doomi/models/database%20models/project.dart';
import 'package:doomi/models/response.dart';
import 'package:doomi/providers/errors_provider.dart';
import 'package:doomi/providers/online_storage_provider.dart';
import 'package:doomi/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final projectsProvider =
    StateNotifierProvider<ProjectsNotifier, Response<List<Project>>>(
  (ref) => ProjectsNotifier(
    db: ref.watch(onlineStorageProvider),
    userID: ref.watch(userProvider)!.id,
    errorsNotifier: ref.read(errorsProvider.notifier),
  ),
);

class ProjectsNotifier extends StateNotifier<Response<List<Project>>> {
  final IOnlineStorage db;
  final ErrorsNotifier errorsNotifier;
  final String userID;

  ProjectsNotifier({
    required this.db,
    required this.errorsNotifier,
    required this.userID,
    List<Project>? initial,
  }) : super(
          initial == null ? Response.loading() : Response.completed(initial),
        ) {
    if (initial == null) _init();
  }

  void _init() async {
    try {
      List<Project> projects = await db.getUserProjects(userID);
      state = Response.completed(projects);
    } on Exception catch (e, s) {
      state = Response.error();
      errorsNotifier.recordError(e, s: s);
    }
  }

  void addProject(Project project) async {
    Project updated = await db.addProject(project);
    state = Response.completed([...state.data!, updated]);
  }

  Future<void> deleteProject(Project p) async {
    await db.deleteProject(p.id);

    List<Project> updated = List.from(state.data!);
    updated.remove(p);
    state = Response.completed(updated);
  }

  void editProject(Project edited) async {
    await db.updateProject(edited);
    List<Project> updated = List.from(state.data!);
    // Project equality depends on the id only
    // so we can safely filter by equality here
    int index = updated.indexOf(edited);
    if (index != -1) {
      updated[index] = edited;
      state = Response.completed(updated);
    }
  }
}
