class CreatePollRequest {
  CreatePollRequest({
    required this.id,
  });

  final String id;

  factory CreatePollRequest.fromJson(Map<String, dynamic> json){
    return CreatePollRequest(
      id: json["id"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
  };

}
