import 'package:csv/csv.dart';
import 'package:doomi/interfaces/csv.dart';
import 'package:doomi/models/database%20models/project.dart';
import 'package:doomi/models/database%20models/status.dart';
import 'package:doomi/models/database%20models/task.dart';
import 'package:doomi/services/csv_service.dart';
import 'package:doomi/utils/enums.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:intl/intl.dart';
import 'package:mockito/mockito.dart';

void main() {
  late ICsvService csvService;
  late Status mockStatus;
  late Task mockTask;
  late Project mockProject;

  setUp(
    () {
      csvService = CsvService();
      mockStatus = Status(
          id: 'status_1',
          title: 'Status title',
          description: '',
          projectId: '');
      mockTask = Task(
        id: 'id',
        dateCompleted: DateTime(2022, 5, 5),
        statusId: 'status_1',
        projectID: 'projectID',
        title: 'Task title',
        istrackingTime: false,
        description: 'Task description',
        startingDate: DateTime(2022, 1, 1),
        dueDate: DateTime(2022, 1, 10),
        timeSpent: Duration.zero,
      );
      mockProject = Project(
        id: 'id',
        userId: 'userId',
        title: 'Project title',
        description: 'Project description',
        startingDate: DateTime(2022, 1, 1),
        dueDate: DateTime(2022, 1, 31),
        status: ProjectStatus.active,
      );
    },
  );

  group('exportProjectToCsv', () {
    test('exports project data to CSV format', () async {
      // Arrange
      final statuses = [mockStatus];
      final tasks = [mockTask];
      const locale = 'en_US';

      final expectedCsvData = [
        ['Project Name:', 'Project title'],
        ['Project Description:', 'Project description'],
        ['Start date:', DateFormat.yMd(locale).format(DateTime(2022, 1, 1))],
        ['Due date:', DateFormat.yMd(locale).format(DateTime(2022, 1, 31))],
        ['Tasks:'],
        ['Title', 'Status', 'Starting Date', 'Due Date', 'Completion Date'],
        [
          'Task title',
          'Status title',
          DateFormat.yMd(locale).format(DateTime(2022, 1, 1)),
          DateFormat.yMd(locale).format(DateTime(2022, 1, 10)),
          DateFormat.yMd(locale).format(DateTime(2022, 5, 5)),
        ],
      ];
      final expectedCsv = const ListToCsvConverter().convert(expectedCsvData);

      // Act
      final actualCsv = await csvService.exportProjectToCsv(
        project: mockProject,
        statuses: statuses,
        tasks: tasks,
        locale: locale,
      );

      // Assert
      expect(actualCsv, equals(expectedCsv));
    });
  });
}
