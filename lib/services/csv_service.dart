import 'package:csv/csv.dart';
import 'package:doomi/interfaces/csv.dart';
import 'package:doomi/models/database%20models/project.dart';
import 'package:doomi/models/database%20models/status.dart';
import 'package:doomi/models/database%20models/task.dart';
import 'package:intl/intl.dart';

class CsvService implements ICsvService {
  @override
  Future<String> exportProjectToCsv({
    required Project project,
    required List<Status> statuses,
    required List<Task> tasks,
    required String locale,
  }) async {
    List<List<dynamic>> csvData = [
      [
        'Project Name:',
        project.title,
      ],
      [
        'Project Description:',
        project.description,
      ],
      [
        'Start date:',
        DateFormat.yMd(locale).format(project.startingDate),
      ],
      [
        'Due date:',
        DateFormat.yMd(locale).format(project.dueDate),
      ],
      [
        'Tasks:',
      ],
      [
        'Title',
        'Starting Date',
        'Due Date',
        'Status',
      ]
    ];

    for (Task task in tasks) {
      List<dynamic> taskData = [
        task.title,
        DateFormat.yMd(locale).format(task.startingDate),
        DateFormat.yMd(locale).format(task.dueDate),
        statuses.firstWhere((element) => element.id == task.statusId).title,
      ];

      csvData.add(taskData);
    }

    String csv = const ListToCsvConverter().convert(csvData);

    return csv;
  }
}
