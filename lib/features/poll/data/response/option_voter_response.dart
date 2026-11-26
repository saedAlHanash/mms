/// One voter from `Vote/GetOptionVoters` (tolerant of the party being nested or flat).
class OptionVoter {
  const OptionVoter({required this.partyId, required this.name, required this.reason});

  final String partyId;
  final String name;

  /// The reason given when objecting or abstaining, if any.
  final String reason;

  factory OptionVoter.fromJson(Map<String, dynamic> json) {
    final party = json['party'] is Map<String, dynamic> ? json['party'] as Map<String, dynamic> : const {};
    String str(Object? v) => v?.toString().trim() ?? '';
    final parts = [party['firstName'], party['middleName'], party['lastName']].map(str).where((e) => e.isNotEmpty);
    final name = [json['name'], json['partyName'], json['fullName'], party['name']]
        .map(str)
        .firstWhere((e) => e.isNotEmpty, orElse: () => parts.join(' '));
    return OptionVoter(
      partyId: str(json['partyId'] ?? party['id']),
      name: name,
      reason: str(json['reason']),
    );
  }
}
