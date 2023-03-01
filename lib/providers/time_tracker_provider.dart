import 'dart:async';

import 'package:doomi/interfaces/online_storage.dart';
import 'package:doomi/models/database%20models/task.dart';
import 'package:doomi/providers/online_storage_provider.dart';
import 'package:doomi/providers/tasks_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final timeTrackerProvider = ChangeNotifierProvider.family.autoDispose(
  (ref, Task task) => TimeTrackerNotifier(
    task,
    ref.read(tasksProvider(task.projectID).notifier),
    ref.read(onlineStorageProvider),
  ),
);

class TimeTrackerNotifier extends ChangeNotifier {
  TimeTrackerNotifier(this.task, this.tasksNotifier, this.db) {
    if (task.istrackingTime && task.latestShiftDate != null) {
      timeSpent =
          task.timeSpent + DateTime.now().difference(task.latestShiftDate!);

      _initializeTimer();
    } else {
      timeSpent = task.timeSpent;
    }
  }
  final IOnlineStorage db;
  final TasksNotifier tasksNotifier;
  final Task task;

  late Duration timeSpent;

  Timer? _secondsTimer;

  void startTracking() async {
    Task updated = task.startTracking(timeSpent);
    tasksNotifier.editTask(updated);

    _initializeTimer();

    notifyListeners();
  }

  void _initializeTimer() {
    _secondsTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => _updateUi());
  }

  void stopTracking() {
    _secondsTimer?.cancel();

    Task updated = task.stopTracking(timeSpent);
    tasksNotifier.editTask(updated);
    // task = updated;
    notifyListeners();
    // Save to db
  }

  _updateUi() {
    timeSpent = timeSpent + const Duration(seconds: 1);
    notifyListeners();
  }

  @override
  void dispose() {
    _secondsTimer?.cancel();
    super.dispose();
  }
}
