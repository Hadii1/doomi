class Status {
  final String id;
  final String projectId;
  final String title;
  final String description;

  Status({
    required this.id,
    required this.title,
    required this.description,
    required this.projectId,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'projectId': projectId});
    result.addAll({'title': title});
    result.addAll({'description': description});

    return result;
  }

  factory Status.fromMap(Map<String, dynamic> map) {
    return Status(
      id: map['id'] ?? '',
      projectId: map['projectId'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
    );
  }

  Status assingId(String newId) => Status(
        id: newId,
        title: title,
        description: description,
        projectId: projectId,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Status && other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
