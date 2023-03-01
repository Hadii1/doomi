import 'package:doomi/models/database%20models/task.dart';
import 'package:doomi/providers/tasks_provider.dart';
import 'package:doomi/providers/time_tracker_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../mock_objects.dart/app_initialization_test.mocks.dart';
import '../mock_objects.dart/time_tracker_test.mocks.dart';

@GenerateNiceMocks([MockSpec<TasksNotifier>()])
void main() {
  group('TaskTimeTracker', () {
    late TasksNotifier mockTasksNotifier;
    late Task task;
    // late ProviderContainer container;
    late TimeTrackerNotifier taskTimeTracker;

    setUp(() {
      mockTasksNotifier = MockTasksNotifier();
      task = Task(
        id: '1',
        title: 'Task',
        projectID: '1',
        statusId: '',
        description: '',
        dueDate: DateTime.now(),
        istrackingTime: false,
        startingDate: DateTime.now(),
        timeSpent: Duration.zero,
        latestShiftDate: null,
      );

      taskTimeTracker =
          TimeTrackerNotifier(task, mockTasksNotifier, MockIOnlineStorage());
    });

    test('startTracking', () {
      final updatedTask = task.startTracking(Duration.zero);

      when(mockTasksNotifier.editTask(updatedTask)).thenAnswer((_) async {});

      taskTimeTracker.startTracking();

      verify(mockTasksNotifier.editTask(updatedTask));
      expect(updatedTask.istrackingTime, true);
      expect(updatedTask.latestShiftDate!.minute, DateTime.now().minute);
      expect(taskTimeTracker.timeSpent, Duration.zero);
    });

    test('stopTracking', () async {
      const timeSpent = Duration(minutes: 5);
      taskTimeTracker.timeSpent = timeSpent;

      final updatedTask = task.stopTracking(timeSpent);

      taskTimeTracker.stopTracking();

      verify(mockTasksNotifier.editTask(updatedTask));
      expect(taskTimeTracker.task.istrackingTime, false);
      expect(taskTimeTracker.task.latestShiftDate, null);
      expect(taskTimeTracker.timeSpent, timeSpent);
    });
  });
}
