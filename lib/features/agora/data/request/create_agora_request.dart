import '../response/agora_response.dart';

class CreateAgoraRequest {
  CreateAgoraRequest({
    required this.id,
  });

  final String id;

  factory CreateAgoraRequest.fromJson(Map<String, dynamic> json) {
    return CreateAgoraRequest(
      id: json["id"] ?? "",
    );
  }

  factory CreateAgoraRequest.fromAgora(Agora agora) {
    return CreateAgoraRequest(
      id: agora.id.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

