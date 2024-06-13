class CreateTempRequest {
  CreateTempRequest({
    required this.id,
  });

  final String id;

  factory CreateTempRequest.fromJson(Map<String, dynamic> json){
    return CreateTempRequest(
      id: json["id"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
  };

}
