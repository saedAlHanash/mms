class MeetingsResponse {
  MeetingsResponse({
    required this.items,
    required this.currentPage,
    required this.totalPages,
    required this.pageSize,
    required this.totalCount,
    required this.hasPrevious,
    required this.hasNext,
  });

  final List<Meeting> items;
  final num currentPage;
  final num totalPages;
  final num pageSize;
  final num totalCount;
  final bool hasPrevious;
  final bool hasNext;

  factory MeetingsResponse.fromJson(Map<String, dynamic> json) {
    return MeetingsResponse(
      items: json["items"] == null
          ? []
          : List<Meeting>.from(json["items"]!.map((x) => Meeting.fromJson(x))),
      currentPage: json["currentPage"] ?? 0,
      totalPages: json["totalPages"] ?? 0,
      pageSize: json["pageSize"] ?? 0,
      totalCount: json["totalCount"] ?? 0,
      hasPrevious: json["hasPrevious"] ?? false,
      hasNext: json["hasNext"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "items": items.map((x) => x?.toJson()).toList(),
        "currentPage": currentPage,
        "totalPages": totalPages,
        "pageSize": pageSize,
        "totalCount": totalCount,
        "hasPrevious": hasPrevious,
        "hasNext": hasNext,
      };
}

class Meeting {
  Meeting({
    required this.id,
    required this.title,
    required this.meetingPlace,
    required this.fromDate,
    required this.toDate,
    required this.scheduledDate,
    required this.status,
    required this.committeeId,
  });

  final String id;
  final String title;
  final String meetingPlace;
  final DateTime? fromDate;
  final DateTime? toDate;
  final DateTime? scheduledDate;
  final num status;
  final String committeeId;

  factory Meeting.fromJson(Map<String, dynamic> json) {
    return Meeting(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      meetingPlace: json["meetingPlace"] ?? "",
      fromDate: DateTime.tryParse(json["fromDate"] ?? ""),
      toDate: DateTime.tryParse(json["toDate"] ?? ""),
      scheduledDate: DateTime.tryParse(json["scheduledDate"] ?? ""),
      status: json["status"] ?? 0,
      committeeId: json["committeeId"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "meetingPlace": meetingPlace,
        "fromDate": fromDate?.toIso8601String(),
        "toDate": toDate?.toIso8601String(),
        "scheduledDate": scheduledDate?.toIso8601String(),
        "status": status,
        "committeeId": committeeId,
      };
}
