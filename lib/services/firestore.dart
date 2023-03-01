import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doomi/interfaces/online_storage.dart';
import 'package:doomi/models/database%20models/project.dart';
import 'package:doomi/models/database%20models/status.dart';
import 'package:doomi/models/database%20models/task.dart';
import 'package:doomi/models/database%20models/user.dart';

class FirestoreService extends IOnlineStorage {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<User?> getUser(String id) async {
    DocumentSnapshot<Map<String, dynamic>> data =
        await _db.collection('users').doc(id).get();

    if (data.data() == null) return null;
    return User.fromMap(data.data()!);
  }

  @override
  Future<void> saveUser(User user) async {
    await _db.collection('users').doc(user.id).set(user.toMap());
  }

  @override
  Future<Status> addStatus(Status status) async {
    DocumentReference ref = _db.collection('statuses').doc();
    Status updated = status.assingId(ref.id);
    await ref.set(updated.toMap());
    return updated;
  }

  @override
  Future<Project> addProject(Project project) async {
    DocumentReference ref = _db.collection('projects').doc();
    Project updated = project.assignId(ref.id);
    await ref.set(updated.toMap());
    return updated;
  }

  @override
  Future<Task> addTask(Task task) async {
    DocumentReference ref = _db.collection('tasks').doc();
    Task updated = task.assignId(ref.id);
    await ref.set(updated.toMap());
    return updated;
  }

  @override
  Future<void> deleteStatus(String statusId) async {
    await _db.collection('statuses').doc(statusId).delete();
  }

  @override
  Future<void> deleteProject(String projectId) async {
    await _db.collection('projects').doc(projectId).delete();
  }

  @override
  Future<void> deleteTask(String taskId) async {
    await _db.collection('tasks').doc(taskId).delete();
  }

  @override
  Future<List<Status>> getProjectStatuses(String projectId) async {
    QuerySnapshot<Map<String, dynamic>> data = await _db
        .collection('statuses')
        .where('projectId', isEqualTo: projectId)
        // .orderBy('created_at', descending: false)
        .get();
    return data.docs.map((e) => Status.fromMap(e.data())).toList();
  }

  @override
  Future<List<Task>> getProjectTasks(String projectId) async {
    QuerySnapshot<Map<String, dynamic>> data = await _db
        .collection('tasks')
        .where('projectID', isEqualTo: projectId)
        .get();
    return data.docs.map((e) => Task.fromMap(e.data())).toList();
  }

  @override
  Future<List<Project>> getUserProjects(String userId) async {
    QuerySnapshot<Map<String, dynamic>> data = await _db
        .collection('projects')
        .where('userId', isEqualTo: userId)
        .get();
    return data.docs.map((e) => Project.fromMap(e.data())).toList();
  }

  @override
  Future<void> updateStatus(Status status) async {
    await _db.collection('statuses').doc(status.id).update(status.toMap());
  }

  @override
  Future<void> updateProject(Project project) async {
    await _db.collection('projects').doc(project.id).update(project.toMap());
  }

  @override
  Future<void> updateTask(Task task) async {
    await _db.collection('tasks').doc(task.id).update(task.toMap());
  }
}
