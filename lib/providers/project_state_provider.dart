import 'package:doomi/interfaces/online_storage.dart';
import 'package:doomi/models/database%20models/project.dart';
import 'package:doomi/providers/online_storage_provider.dart';
import 'package:doomi/providers/projects_provider.dart';
import 'package:doomi/providers/user_provider.dart';
import 'package:doomi/utils/enums.dart';
import 'package:doomi/utils/exceptions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// This is used to track the state of either a project being created
// or a project being edited.
// Null is used when creating a new project.
final projectStateProvider = ChangeNotifierProvider.autoDispose.family(
  (ref, Project? p) => ProjectStateNotifier(
    project: p,
    projectsNotifier: ref.read(projectsProvider.notifier),
    userID: ref.read(userProvider)!.id,
    onlineStorage: ref.read(onlineStorageProvider),
  ),
);

class ProjectStateNotifier extends ChangeNotifier {
  late String title;
  late String description;
  late DateTime startingDate;
  late DateTime dueDate;
  late ProjectStatus status;

  final Project? project;
  final IOnlineStorage onlineStorage;
  final ProjectsNotifier projectsNotifier;
  final String userID;

  ProjectStateNotifier({
    required this.project,
    required this.onlineStorage,
    required this.projectsNotifier,
    required this.userID,
  }) {
    title = project?.title ?? '';
    description = project?.description ?? '';
    status = project?.status ?? ProjectStatus.active;
    startingDate = project?.startingDate ?? DateTime.now();
    dueDate = project?.dueDate ??
        DateTime.now().add(
          const Duration(days: 7),
        );
  }

  void setProjectName(String name) {
    title = name.trim();
    notifyListeners();
  }

  void setProjectDescription(String desc) {
    description = desc.trim();
    notifyListeners();
  }

  void setProjectStatus(ProjectStatus s) {
    status = s;
    notifyListeners();
  }

  void setStartingDate(DateTime date) {
    startingDate = date;
    notifyListeners();
  }

  void setDueDate(DateTime date) {
    dueDate = date;
    notifyListeners();
  }

  bool get isProjectValid {
    if (project != null) {
      if (didInfoChange == false) return false;
    }
    return title.isNotEmpty && description.isNotEmpty;
  }

  // Used in case if editing an existing project to
  // check if data has been edited
  bool get didInfoChange {
    if (project == null) return true;
    return title != project!.title ||
        description != project!.description ||
        status != project!.status ||
        startingDate != project!.startingDate ||
        dueDate != project!.dueDate;
  }

  Future<void> onActionPressed() async {
    if (startingDate.isAfter(dueDate)) {
      throw StartDateAfterThanDueDate();
    }
    if (project == null) {
      Project p = Project(
        id: '',
        userId: userID,
        description: description,
        dueDate: dueDate,
        startingDate: startingDate,
        status: status,
        title: title,
      );

      projectsNotifier.addProject(p);
    } else {
      Project p = Project(
        id: project!.id,
        userId: project!.userId,
        title: title,
        description: description,
        status: status,
        dueDate: dueDate,
        startingDate: startingDate,
      );

      projectsNotifier.editProject(p);
    }
  }
}
