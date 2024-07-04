

class Attendee {
  Attendee({
    required this.id,
    required this.attendanceDate,
    required this.hasAttended,
    required this.partyId,
    required this.fullName,
  });

  final String id;
  final DateTime? attendanceDate;
  final bool hasAttended;
  final String partyId;
  final String fullName;

  factory Attendee.fromJson(Map<String, dynamic> json) {
    return Attendee(
      id: json["id"] ?? "",
      attendanceDate: DateTime.tryParse(json["attendanceDate"] ?? ""),
      hasAttended: json["hasAttended"] ?? false,
      partyId: json["partyId"] ?? "",
      fullName:json["fullName"] ??'',
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "attendanceDate": attendanceDate?.toIso8601String(),
        "hasAttended": hasAttended,
        "partyId": partyId,
        "fullName": fullName,
      };
}
