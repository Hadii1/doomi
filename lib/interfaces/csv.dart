import 'package:doomi/models/database%20models/status.dart';
import 'package:doomi/models/database%20models/project.dart';
import 'package:doomi/models/database%20models/task.dart';

abstract class ICsvService {
  Future<String> exportProjectToCsv({
    required Project project,
    required List<Status> statuses,
    required List<Task> tasks,
    required String locale,
  });
}
