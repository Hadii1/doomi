import 'package:doomi/interfaces/online_storage.dart';
import 'package:doomi/models/database%20models/status.dart';
import 'package:doomi/models/database%20models/project.dart';
import 'package:doomi/providers/statuses_provider.dart';
import 'package:doomi/providers/online_storage_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// This is used to track the state of either a status being created
// or a status being edited.
// Null is used when creating a new status.

class StatusProviderArg {
  Status? status;
  Project project;

  StatusProviderArg({
    this.status,
    required this.project,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StatusProviderArg &&
        other.status == status &&
        other.project == project;
  }

  @override
  int get hashCode => status.hashCode ^ project.hashCode;
}

final statusStateProvider = ChangeNotifierProvider.autoDispose.family(
  (ref, StatusProviderArg b) => StatusStateNotifier(
    status: b.status,
    statusesNotifier: ref.read(statusesProvider(b.project.id).notifier),
    db: ref.watch(onlineStorageProvider),
    projectId: b.project.id,
  ),
);

class StatusStateNotifier extends ChangeNotifier {
  final IOnlineStorage db;
  late String title;
  late String description;

  final Status? status;
  final String projectId;

  final StatusesNotifier statusesNotifier;

  StatusStateNotifier({
    required this.status,
    required this.projectId,
    required this.statusesNotifier,
    required this.db,
  }) {
    title = status?.title ?? '';
    description = status?.description ?? '';
  }

  void setStatusName(String name) {
    title = name.trim();
    notifyListeners();
  }

  void setStatusDescription(String desc) {
    description = desc.trim();
    notifyListeners();
  }

  bool get isStatusValid {
    if (status != null) {
      if (didInfoChange == false) return false;
    }
    return title.isNotEmpty && description.isNotEmpty;
  }

  // Used in case if editing an existing status to
  // check if data has been edited
  bool get didInfoChange {
    if (status == null) return true;
    return title != status!.title || description != status!.description;
  }

  Future<void> onActionPressed() async {
    if (status == null) {
      Status s = Status(
        id: '',
        title: title,
        description: description,
        projectId: projectId,
      );

      statusesNotifier.addStatus(s);
    } else {
      Status updated = Status(
        id: status!.id,
        title: title,
        description: description,
        projectId: status!.projectId,
      );

      statusesNotifier.editStatus(updated);
    }
  }
}
