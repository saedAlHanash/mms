import 'package:mms/core/app/app_provider.dart';

class CreateVoteRequest {
  CreateVoteRequest({
     this.pollId,
     this.pollOptionId,
     this.id,
  });

   String? pollId;
   String? pollOptionId;
   String? id;

  factory CreateVoteRequest.fromJson(Map<String, dynamic> json) {
    return CreateVoteRequest(
      id: json["id"] ?? "",
      pollId: json["pollId"] ?? "",
      pollOptionId: json["pollOptionId"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "pollId": pollId,
        "pollOptionId": pollOptionId,
        "partyId": AppProvider.getParty.id,
      };
}
