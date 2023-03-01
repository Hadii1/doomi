import 'dart:io';

import 'package:doomi/interfaces/csv.dart';
import 'package:doomi/interfaces/files.dart';
import 'package:doomi/models/database%20models/project.dart';
import 'package:doomi/models/database%20models/status.dart';
import 'package:doomi/models/database%20models/task.dart';
import 'package:doomi/providers/csv_service_provider.dart';
import 'package:doomi/providers/file_service_provider.dart';
import 'package:doomi/providers/locale_provider.dart';
import 'package:doomi/providers/statuses_provider.dart';
import 'package:doomi/providers/tasks_provider.dart';
import 'package:doomi/utils/enums.dart';
import 'package:doomi/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final csvNotifierProvider = ChangeNotifierProvider.family.autoDispose(
  (ref, Project p) => CsvNotifier(
      csvService: ref.watch(csvServiceProvider),
      filesService: ref.watch(filesServiceProvider),
      project: p,
      tasksNotifier: ref.read(tasksProvider(p.id).notifier),
      locale: ref.watch(localProvider),
      statusesNotifier: ref.read(statusesProvider(p.id).notifier)),
);

class CsvNotifier extends ChangeNotifier {
  final Project project;
  final DoomiLocale locale;
  final ICsvService csvService;
  final IFilesService filesService;
  final TasksNotifier tasksNotifier;
  final StatusesNotifier statusesNotifier;

  CsvNotifier({
    required this.project,
    required this.tasksNotifier,
    required this.locale,
    required this.statusesNotifier,
    required this.csvService,
    required this.filesService,
  });

  Future<File> convertProjectToCsv() async {
    List<Status> statuses = await statusesNotifier.getStatuses();
    List<Task> tasks = await tasksNotifier.getTasks();

    String csv = await csvService.exportProjectToCsv(
      project: project,
      statuses: statuses,
      tasks: tasks,
      locale: locale.getOfficialLocal.languageCode,
    );

    File f = await filesService.writeFile('${project.title}.csv', csv);
    return f;
  }
}
