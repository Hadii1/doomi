import 'package:doomi/models/database%20models/status.dart';
import 'package:doomi/models/database%20models/project.dart';
import 'package:doomi/models/database%20models/task.dart';
import 'package:doomi/models/database%20models/user.dart';

abstract class IOnlineStorage {
  Future<User?> getUser(String id);

  Future<void> saveUser(User user);

  // returns the project associated with it's new id
  Future<Project> addProject(Project project);
  Future<void> deleteProject(String projectId);
  Future<void> updateProject(Project project);
  Future<List<Project>> getUserProjects(String userId);

  // returns the board associated with it's new id
  Future<Status> addStatus(Status status);
  Future<void> deleteStatus(String statusId);
  Future<void> updateStatus(Status status);
  Future<List<Status>> getProjectStatuses(String projectId);

  // returns the task associated with it's new id
  Future<Task> addTask(Task task);
  Future<void> deleteTask(String taskId);
  Future<void> updateTask(Task task);
  Future<List<Task>> getProjectTasks(String projectId);
}
