/// A declared conflict of interest in an agenda item (`InterestDisclosureDto`).
class InterestDisclosure {
  const InterestDisclosure({
    required this.id,
    required this.meetingId,
    required this.agendaItemId,
    required this.agendaItemTitle,
    required this.partyId,
    required this.name,
    required this.note,
    required this.created,
  });

  final String id;
  final String meetingId;
  final String agendaItemId;
  final String agendaItemTitle;
  final String partyId;
  final String name;
  final String note;
  final DateTime? created;

  factory InterestDisclosure.fromJson(Map<String, dynamic> json) {
    // Single results may come wrapped in `data`.
    final map = json['data'] is Map<String, dynamic> ? json['data'] as Map<String, dynamic> : json;
    return InterestDisclosure(
      id: map['id'] ?? '',
      meetingId: map['meetingId'] ?? '',
      agendaItemId: map['agendaItemId'] ?? '',
      agendaItemTitle: map['agendaItemTitle'] ?? '',
      partyId: map['partyId'] ?? '',
      name: map['name'] ?? '',
      note: map['note'] ?? '',
      created: DateTime.tryParse(map['created'] ?? '')?.toLocal(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'meetingId': meetingId,
    'agendaItemId': agendaItemId,
    'agendaItemTitle': agendaItemTitle,
    'partyId': partyId,
    'name': name,
    'note': note,
    'created': created?.toIso8601String(),
  };
}
