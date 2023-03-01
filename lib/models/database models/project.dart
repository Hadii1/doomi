import 'package:doomi/utils/enums.dart';

class Project {
  final String id;
  final String userId;
  final String title;
  final String description;
  final DateTime startingDate;
  final DateTime dueDate;
  final ProjectStatus status;

  Project({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.startingDate,
    required this.dueDate,
    required this.status,
  });

  Project assignId(String newId) => Project(
        userId: userId,
        id: newId,
        title: title,
        description: description,
        startingDate: startingDate,
        dueDate: dueDate,
        status: status,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Project && other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'userId': userId});
    result.addAll({'title': title});
    result.addAll({'description': description});
    result.addAll({'startingDate': startingDate.millisecondsSinceEpoch});
    result.addAll({'dueDate': dueDate.millisecondsSinceEpoch});
    result.addAll({'status': status.name});

    return result;
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    late ProjectStatus status;

    for (ProjectStatus s in ProjectStatus.values) {
      if (map['status'] == s.name) {
        status = s;
        break;
      }
    }

    return Project(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      startingDate: DateTime.fromMillisecondsSinceEpoch(map['startingDate']),
      dueDate: DateTime.fromMillisecondsSinceEpoch(map['dueDate']),
      status: status,
    );
  }
}
