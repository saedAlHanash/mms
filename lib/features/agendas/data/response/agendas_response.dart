import 'package:collection/collection.dart';
import 'package:mms/core/app/app_provider.dart';

import '../../../members/data/response/member_response.dart';

class Agenda {
  Agenda({
    required this.id,
    required this.title,
    required this.description,
    required this.fromDate,
    required this.toDate,
    required this.meetingId,
    required this.parentId,
    required this.comments,
    required this.childrenItems,
  });

  final String id;
  final String title;
  final String description;
  final DateTime? fromDate;
  final DateTime? toDate;
  final String meetingId;
  final String parentId;
  final List<Comment> comments;
  final List<String> childrenItems;

  bool get haveMyComment =>
      comments.firstWhereOrNull((e) => e.partyId == AppProvider.getParty.id) !=
      null;
  Comment? get myComment =>
      comments.firstWhereOrNull((e) => e.partyId == AppProvider.getParty.id);

  factory Agenda.fromJson(Map<String, dynamic> json) {
    return Agenda(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      description: json["description"] ?? "",
      fromDate: DateTime.tryParse(json["fromDate"] ?? ""),
      toDate: DateTime.tryParse(json["toDate"] ?? ""),
      meetingId: json["meetingId"] ?? "",
      parentId: json["parentId"] ?? "",
      comments: json["comments"] == null
          ? []
          : List<Comment>.from(
              json["comments"]!.map((x) => Comment.fromJson(x))),
      childrenItems: json["childrenItems"] == null
          ? []
          : List<String>.from(json["childrenItems"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "fromDate": fromDate?.toIso8601String(),
        "toDate": toDate?.toIso8601String(),
        "meetingId": meetingId,
        "parentId": parentId,
        "comments": comments.map((x) => x.toJson()).toList(),
        "childrenItems": childrenItems.map((x) => x).toList(),
      };
}

class Comment {
  Comment({
    required this.id,
    required this.text,
    required this.date,
    required this.partyId,
    required this.party,
    required this.agendaItemId,
  });

  final String id;
  final String text;
  final DateTime? date;
  final String partyId;
  final Party party;
  final String agendaItemId;

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json["id"] ?? "",
      text: json["text"] ?? "",
      date: DateTime.tryParse(json["date"] ?? ""),
      partyId: json["partyId"] ?? "",
      party: Party.fromJson(json["party"] ?? {}),
      agendaItemId: json["agendaItemId"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "date": date?.toIso8601String(),
        "partyId": partyId,
        "party": party.toJson(),
        "agendaItemId": agendaItemId,
      };
}
