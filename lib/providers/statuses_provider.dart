import 'package:doomi/interfaces/online_storage.dart';
import 'package:doomi/models/response.dart';
import 'package:doomi/models/database%20models/status.dart';
import 'package:doomi/providers/errors_provider.dart';
import 'package:doomi/providers/online_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final statusesProvider = StateNotifierProvider.family
    .autoDispose<StatusesNotifier, Response<List<Status>>, String>(
  (ref, String project) => StatusesNotifier(
    project: project,
    db: ref.watch(onlineStorageProvider),
    errorsNotifier: ref.watch(errorsProvider.notifier),
  ),
);

class StatusesNotifier extends StateNotifier<Response<List<Status>>> {
  final String project;
  final IOnlineStorage db;
  final ErrorsNotifier errorsNotifier;

  StatusesNotifier({
    required this.project,
    required this.db,
    required this.errorsNotifier,
    List<Status>? testValue,
  }) : super(testValue == null
            ? Response.loading()
            : Response.completed(testValue)) {
    if (testValue == null) _init();
  }

  Future<void> _init() async {
    try {
      List<Status> statuses = await getStatuses();
      if (mounted) state = Response.completed(statuses);
    } on Exception catch (e, s) {
      errorsNotifier.recordError(e, s: s);
      state = Response.error(e: e);
    }
  }

  Future<List<Status>> getStatuses() async =>
      await db.getProjectStatuses(project);


  void addStatus(Status status) async {
    Status updated = await db.addStatus(status);
    state = Response.completed([...state.data!, updated]);
  }

  void deleteStatus(Status s) async {
    // TODO: Delete all tasks related to this status
    await db.deleteStatus(s.id);
    List<Status> updated = List.from(state.data!);
    updated.remove(s);
    state = Response.completed(updated);
  }

  void editStatus(Status edited) async {
    await db.updateStatus(edited);
    List<Status> updated = List.from(state.data!);
    // Project equality depends on the id only
    // so we can safely filter by equality here
    int index = updated.indexOf(edited);
    if (index != -1) {
      updated[index] = edited;
      state = Response.completed(updated);
    }
  }
}
