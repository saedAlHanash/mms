import 'package:mms/core/app/app_provider.dart';

class AddCommentRequest {
  AddCommentRequest({
    this.text,
    this.agendaItemId,
    this.discussionId,
  });

  String? text;
  String? agendaItemId;
  String? discussionId;


  factory AddCommentRequest.fromJson(Map<String, dynamic> json) {
    return AddCommentRequest(
      text: json["text"] ?? "",
      agendaItemId: json["agendaItemId"] ?? "",
      discussionId: json["discussionId"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "text": text,
        "partyId": AppProvider.getParty.id,
        "agendaItemId": agendaItemId,
        "discussionId": discussionId,
      };
}
