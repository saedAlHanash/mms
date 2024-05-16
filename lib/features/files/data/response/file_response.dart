class FileResponse {
  FileResponse({
    required this.fileName,
    required this.originalFileName,
    required this.savedPath,
    required this.mime,
    required this.id,
  });

  final String fileName;
  final String originalFileName;
  final String savedPath;
  final String mime;
  final String id;

  factory FileResponse.fromJson(Map<String, dynamic> json) {
    return FileResponse(
      fileName: json["fileName"] ?? "",
      originalFileName: json["originalFileName"] ?? "",
      savedPath: json["savedPath"] ?? "",
      mime: json["mime"] ?? "",
      id: json["id"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "fileName": fileName,
        "originalFileName": originalFileName,
        "savedPath": savedPath,
        "mime": mime,
        "id": id,
      };
}
