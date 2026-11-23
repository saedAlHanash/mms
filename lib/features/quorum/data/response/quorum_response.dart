int _int(Object? v) => int.tryParse(v?.toString() ?? '') ?? 0;

int? _intOrNull(Object? v) => int.tryParse(v?.toString() ?? '');

bool? _boolOrNull(Object? v) => v is bool ? v : null;

/// `QuorumType`: a head count, or a percentage of the base.
enum QuorumType { count, percent }

/// `MeetingQuorumDto` from `Quorum/GetForMeeting` (also `quorum` in the live state).
/// Shown and recorded only; the server never enforces it.
class MeetingQuorum {
  MeetingQuorum({
    required this.meetingId,
    required this.excluded,
    required this.presentRemote,
    required this.presentInHall,
    required this.hasRule,
    required this.type,
    required this.value,
    required this.proxiesCount,
    required this.chairRequired,
    required this.base,
    required this.required,
    required this.present,
    required this.proxies,
    required this.chairPresent,
    required this.met,
    required this.recordedRequired,
    required this.recordedPresent,
    required this.recordedMet,
    required this.recordedAt,
  });

  final String meetingId;

  /// Members left out for an item because they declared an interest in it.
  final int excluded;
  final int presentRemote;
  final int presentInHall;

  // The committee's rule.
  final bool hasRule;
  final QuorumType? type;
  final int? value;
  final bool proxiesCount;
  final bool chairRequired;

  // Live figures.
  /// Members and the chair (not the secretary).
  final int base;
  final int required;
  final int present;
  final int proxies;
  final bool chairPresent;
  final bool met;

  // Saved when the meeting was set to Running.
  final int? recordedRequired;
  final int? recordedPresent;
  final bool? recordedMet;
  final DateTime? recordedAt;

  bool get isEmpty => meetingId.isEmpty && !hasRule;

  bool get hasRecord => recordedAt != null && recordedRequired != null && recordedPresent != null;

  /// Met only because of the chair rule: present is enough but the chair is missing.
  bool get missingChair => chairRequired && !chairPresent && present >= required;

  factory MeetingQuorum.empty() => MeetingQuorum.fromJson(const {});

  factory MeetingQuorum.fromJson(Map<String, dynamic> json) {
    final map = json['data'] is Map<String, dynamic> ? json['data'] as Map<String, dynamic> : json;
    final type = _intOrNull(map['type']);
    final excluded = map['excluded'];
    return MeetingQuorum(
      meetingId: map['meetingId'] ?? '',
      excluded: excluded is List ? excluded.length : _int(excluded),
      presentRemote: _int(map['presentRemote']),
      presentInHall: _int(map['presentInHall']),
      hasRule: map['hasRule'] ?? false,
      type: type == null || type < 0 || type >= QuorumType.values.length ? null : QuorumType.values[type],
      value: _intOrNull(map['value']),
      proxiesCount: map['proxiesCount'] ?? false,
      chairRequired: map['chairRequired'] ?? false,
      base: _int(map['base']),
      required: _int(map['required']),
      present: _int(map['present']),
      proxies: _int(map['proxies']),
      chairPresent: map['chairPresent'] ?? false,
      met: map['met'] ?? false,
      recordedRequired: _intOrNull(map['recordedRequired']),
      recordedPresent: _intOrNull(map['recordedPresent']),
      recordedMet: _boolOrNull(map['recordedMet']),
      recordedAt: DateTime.tryParse(map['recordedAt']?.toString() ?? '')?.toLocal(),
    );
  }
}
