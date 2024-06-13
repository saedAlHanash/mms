class CreateNotificationRequest {
  CreateNotificationRequest({
    required this.id,
  });

  final String id;

  factory CreateNotificationRequest.fromJson(Map<String, dynamic> json){
    return CreateNotificationRequest(
      id: json["id"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
  };

}
