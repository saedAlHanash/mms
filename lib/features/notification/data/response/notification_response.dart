import 'package:mms/core/extensions/extensions.dart';

class Notifications {
  Notifications({
    required this.items,
  });

  final List<NotificationModel> items;

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      items: json["items"] == null
          ? []
          : List<NotificationModel>.from(
              json["items"]!.map((x) => NotificationModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "items": items.map((x) => x.toJson()).toList(),
      };
}

class NotificationModel {
  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.data,
    required this.type,
    required this.target,
    required this.userId,
    required this.date,
  });

  final String id;
  final String title;
  final String body;
  final dynamic data;
  final num type;
  final num target;
  final String userId;
  final DateTime? date;

  String get getCreatedAt {
    if (date == null) return '';

    return '${date?.formatTime}\n${date?.formatDate}';
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      body: json["body"] ?? "",
      data: json["data"],
      type: json["type"] ?? 0,
      target: json["target"] ?? 0,
      userId: json["userId"] ?? "",
      date: DateTime.tryParse(json["date"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "data": data,
        "type": type,
        "target": target,
        "userId": userId,
        "date": date?.toIso8601String(),
      };
}
