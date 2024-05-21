import 'package:mms/core/app/app_provider.dart';

class AddGuestRequest {
  AddGuestRequest({
    this.firstName,
    this.lastName,
    this.company,
    this.email,
    this.phone,
    this.meetingId,
  });

  String? firstName;
  String? lastName;
  String? company;
  String? email;
  String? phone;
  String? meetingId;

  factory AddGuestRequest.fromJson(Map<String, dynamic> json) {
    return AddGuestRequest(
      firstName: json["firstName"] ?? "",
      lastName: json["lastName"] ?? "",
      company: json["company"] ?? "",
      email: json["email"] ?? "",
      phone: json["phone"] ?? "",
      meetingId: json["meetingID"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "company": company,
        "email": email,
        "phone": phone,
        "meetingID": AppProvider.getCurrentMeeting.id,
        "partyID": AppProvider.getParty.id,
      };
}
