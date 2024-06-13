class CreateVoteRequest {
  CreateVoteRequest({
    required this.id,
  });

  final String id;

  factory CreateVoteRequest.fromJson(Map<String, dynamic> json){
    return CreateVoteRequest(
      id: json["id"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
  };

}
