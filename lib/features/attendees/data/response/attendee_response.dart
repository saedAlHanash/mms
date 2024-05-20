import '../../../meetings/data/response/meetings_response.dart';
import '../../../members/data/response/member_response.dart';

class Attendee {
  Attendee({
    required this.id,
    required this.attendanceDate,
    required this.hasAttended,
    required this.partyId,
    required this.party,
  });

  final String id;
  final DateTime? attendanceDate;
  final bool hasAttended;
  final String partyId;
  final Party party;

  factory Attendee.fromJson(Map<String, dynamic> json) {
    return Attendee(
      id: json["id"] ?? "",
      attendanceDate: DateTime.tryParse(json["attendanceDate"] ?? ""),
      hasAttended: json["hasAttended"] ?? false,
      partyId: json["partyId"] ?? "",
      party: Party.fromJson(json["party"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "attendanceDate": attendanceDate?.toIso8601String(),
        "hasAttended": hasAttended,
        "partyId": partyId,
        "party": party.toJson(),
      };
}
