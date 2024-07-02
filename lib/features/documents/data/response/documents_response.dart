import 'package:mms/core/extensions/extensions.dart';

class Document {
  Document({
    required this.id,
    required this.documentDate,
    required this.name,
    required this.isPublished,
    required this.media,
  });

  final String id;
  final DateTime? documentDate;
  final String name;
  final bool isPublished;
  final Media media;

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      id: json["id"] ?? "",
      documentDate: DateTime.tryParse(json["documentDate"] ?? ""),
      name: json["name"] ?? "",
      isPublished: json["isPublished"] ?? false,
      media: Media.fromJson(json["media"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "documentDate": documentDate?.toIso8601String(),
        "name": name,
        "isPublished": isPublished,
        "media": media.toJson(),
      };
}

class Media {
  Media({
    required this.id,
    required this.fileName,
    required this.originalFileName,
    required this.savedPath,
    required this.mime,
  });

  final String id;
  final String fileName;
  final String originalFileName;
  final String savedPath;

  final String mime;

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      id: json["id"] ?? "",
      fileName: json["fileName"] ?? "",
      originalFileName: json["originalFileName"] ?? "",
      savedPath: json["savedPath"].toString().fixUrl(),
      mime: json["mime"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "fileName": fileName,
        "originalFileName": originalFileName,
        "savedPath": savedPath,
        "mime": mime,
      };
}
