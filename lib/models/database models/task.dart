class Task {
  final String id;
  final String statusId;
  final String projectID;
  final String title;
  final String description;
  final DateTime startingDate;
  final DateTime dueDate;
  final DateTime? dateCompleted;
  final Duration timeSpent;
  final DateTime? latestShiftDate;
  final bool istrackingTime;

  Task({
    required this.id,
    required this.statusId,
    required this.projectID,
    required this.title,
    this.latestShiftDate,
    this.dateCompleted,
    required this.istrackingTime,
    required this.description,
    required this.startingDate,
    required this.dueDate,
    required this.timeSpent,
  });

  Task startTracking(Duration? timeSpent) {
    return Task(
      istrackingTime: true,
      latestShiftDate: DateTime.now(),
      timeSpent: timeSpent ?? this.timeSpent,
      dateCompleted: dateCompleted,
      id: id,
      statusId: statusId,
      projectID: projectID,
      title: title,
      description: description,
      startingDate: startingDate,
      dueDate: dueDate,
    );
  }

  Task stopTracking(Duration totalSpent) {
    return Task(
      istrackingTime: false,
      latestShiftDate: null,
      timeSpent: totalSpent,
      dateCompleted: dateCompleted,
      id: id,
      statusId: statusId,
      projectID: projectID,
      title: title,
      description: description,
      startingDate: startingDate,
      dueDate: dueDate,
    );
  }

  Task assignId(String newId) {
    return Task(
      id: newId,
      istrackingTime: istrackingTime,
      latestShiftDate: latestShiftDate,
      timeSpent: timeSpent,
      dateCompleted: dateCompleted,
      statusId: statusId,
      projectID: projectID,
      title: title,
      description: description,
      startingDate: startingDate,
      dueDate: dueDate,
    );
  }

  Task changeStatus(String newStatus) {
    return Task(
      id: id,
      istrackingTime: istrackingTime,
      latestShiftDate: latestShiftDate,
      timeSpent: timeSpent,
      dateCompleted: dateCompleted,
      projectID: projectID,
      statusId: newStatus,
      title: title,
      description: description,
      startingDate: startingDate,
      dueDate: dueDate,
    );
  }

  Task markAsCompleted() {
    return Task(
      id: id,
      istrackingTime: istrackingTime,
      latestShiftDate: latestShiftDate,
      timeSpent: timeSpent,
      dateCompleted: DateTime.now(),
      statusId: statusId,
      projectID: projectID,
      title: title,
      description: description,
      startingDate: startingDate,
      dueDate: dueDate,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Task && other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'statusId': statusId});
    result.addAll({'projectID': projectID});
    result.addAll({'title': title});
    result.addAll({'description': description});
    result.addAll({'startingDate': startingDate.millisecondsSinceEpoch});
    result.addAll({'dateCompleted': dateCompleted?.millisecondsSinceEpoch});
    result.addAll({'dueDate': dueDate.millisecondsSinceEpoch});
    result.addAll({'timeSpent': timeSpent.inSeconds});

    result.addAll({'latestShiftDate': latestShiftDate?.toString()});

    result.addAll({'istrackingTime': istrackingTime});

    return result;
  }

  factory Task.fromMap(Map<String, dynamic> map) => Task(
        id: map['id'] ?? '',
        statusId: map['statusId'] ?? '',
        projectID: map['projectID'] ?? '',
        title: map['title'] ?? '',
        description: map['description'] ?? '',
        dateCompleted: map['dateCompleted'] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(map['dateCompleted']),
        startingDate: DateTime.fromMillisecondsSinceEpoch(map['startingDate']),
        dueDate: DateTime.fromMillisecondsSinceEpoch(map['dueDate']),
        timeSpent: Duration(seconds: map['timeSpent']),
        latestShiftDate: map['latestShiftDate'] != null
            ? DateTime.parse(map['latestShiftDate'])
            : null,
        istrackingTime: map['istrackingTime'] ?? false,
      );
}
