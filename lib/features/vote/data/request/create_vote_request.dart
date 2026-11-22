import 'package:mms/core/app/app_provider.dart';

class CreateVoteRequest {
  CreateVoteRequest({
     this.pollId,
     this.pollOptionId,
     this.id,
     this.reason,
  });

   String? pollId;
   String? pollOptionId;
   String? id;

   /// Why the voter objects or abstains (at most 500 characters).
   String? reason;

  factory CreateVoteRequest.fromJson(Map<String, dynamic> json) {
    return CreateVoteRequest(
      id: json["id"] ?? "",
      pollId: json["pollId"] ?? "",
      pollOptionId: json["pollOptionId"] ?? "",
      reason: json["reason"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "pollId": pollId,
        "pollOptionId": pollOptionId,
        "partyId": AppProvider.getParty.id,
        if (reason?.trim().isNotEmpty ?? false) "reason": reason!.trim(),
      };
}
