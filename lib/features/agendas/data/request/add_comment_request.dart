import 'package:mms/core/app/app_provider.dart';

class AddCommentRequest {
  AddCommentRequest({
    this.text,
    this.agendaItemId,
  });

  String? text;
  String? agendaItemId;

  factory AddCommentRequest.fromJson(Map<String, dynamic> json) {
    return AddCommentRequest(
      text: json["text"] ?? "",
      agendaItemId: json["agendaItemId"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "text": text,
        "partyId": AppProvider.getParty.id,
        "agendaItemId": agendaItemId,
      };
}
