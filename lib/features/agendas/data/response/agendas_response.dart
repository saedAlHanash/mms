class Goal {
  Goal({
    required this.id,
    required this.name,
    required this.description,
    required this.goalDate,
    required this.committeeId,
    required this.tasks,
  });

  final String id;
  final String name;
  final String description;
  final DateTime? goalDate;
  final String committeeId;
  final List<Task> tasks;

  factory Goal.fromJson(Map<String, dynamic> json) {
    return Goal(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      description: json["description"] ?? "",
      goalDate: DateTime.tryParse(json["goalDate"] ?? ""),
      committeeId: json["committeeId"] ?? "",
      tasks: json["tasks"] == null
          ? []
          : List<Task>.from(json["tasks"]!.map((x) => Task.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "goalDate": goalDate?.toIso8601String(),
        "committeeId": committeeId,
        "tasks": tasks.map((x) => x.toJson()).toList(),
      };
}

class Task {
  Task({
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
    required this.dueDate,
    required this.goalId,
  });

  final String id;
  final String name;
  final String description;
  final DateTime? startDate;
  final DateTime? dueDate;
  final String goalId;

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      description: json["description"] ?? "",
      startDate: DateTime.tryParse(json["startDate"] ?? ""),
      dueDate: DateTime.tryParse(json["dueDate"] ?? ""),
      goalId: json["goalId"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "startDate": startDate?.toIso8601String(),
        "dueDate": dueDate?.toIso8601String(),
        "goalId": goalId,
      };
}
