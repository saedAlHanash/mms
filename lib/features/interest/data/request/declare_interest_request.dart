/// `DeclareInterestDto`: no `partyId`, so it is declared for the signed-in person.
class DeclareInterestRequest {
  const DeclareInterestRequest({required this.agendaItemId, this.note = ''});

  final String agendaItemId;

  /// Optional, 500 characters at most.
  final String note;

  Map<String, dynamic> toJson() => {
    'agendaItemId': agendaItemId,
    if (note.trim().isNotEmpty) 'note': note.trim(),
  };
}
