import 'dart:ffi';

import '../../../../core/strings/enum_manager.dart';
import '../../../documents/data/response/documents_response.dart';
import '../../../goals/data/response/goals_response.dart';
import '../../../members/data/response/member_response.dart';

class CommitteesResponse {
  CommitteesResponse({
    required this.data,
  });

  final List<Committee> data;

  factory CommitteesResponse.fromJson(Map<String, dynamic> json) {
    return CommitteesResponse(
      data: json['data'] == null
          ? []
          : List<Committee>.from(
              (json['data']).map((x) => Committee.fromJson(x)),
            ),
    );
  }
}

class Committee {
  Committee({
    required this.id,
    required this.name,
    required this.formationDate,
    required this.statement,
    required this.description,
    required this.members,
    required this.documents,
    required this.goals,
  });

  final String id;
  final String name;
  final DateTime? formationDate;
  final String statement;
  final String description;
  final List<Member> members;
  final List<Document> documents;
  final List<Goal> goals;

  factory Committee.fromJson(Map<String, dynamic> json) {
    return Committee(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      formationDate: DateTime.tryParse(json["formationDate"] ?? ""),
      statement: json["statement"] ?? "",
      description: json["description"] ?? "",
      members: json["members"] == null
          ? []
          : List<Member>.from(json["members"]!.map((x) => Member.fromJson(x))),
      documents: json["documents"] == null
          ? []
          : List<Document>.from(
              json["documents"]!.map((x) => Document.fromJson(x))),
      goals: json["goals"] == null
          ? []
          : List<Goal>.from(json["goals"]!.map((x) => Goal.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "formationDate": formationDate?.toIso8601String(),
        "statement": statement,
        "description": description,
        "members": members.map((x) => x.toJson()).toList(),
        "documents": documents.map((x) => x.toJson()).toList(),
        "goals": goals.map((x) => x.toJson()).toList(),
      };
}


