import '../response/live_kit_response.dart';

class CreateLiveKitRequest {
  CreateLiveKitRequest({
    required this.id,
  });

  final String id;

  factory CreateLiveKitRequest.fromJson(Map<String, dynamic> json) {
    return CreateLiveKitRequest(
      id: json["id"] ?? "",
    );
  }

  factory CreateLiveKitRequest.fromLiveKit(LiveKit liveKit) {
    return CreateLiveKitRequest(
      id: liveKit.id.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

