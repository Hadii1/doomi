import 'package:doomi/utils/enums.dart';

class Project {
  final String id;
  final String title;
  final String description;
  final DateTime? startingDate;
  final DateTime? dueDate;
  final List<String> cards;
  final ProjectStatus status;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.startingDate,
    required this.dueDate,
    required this.cards,
    required this.status,
  });
}
