import 'package:mms/core/strings/enum_manager.dart';

int _int(Object? v) => int.tryParse(v?.toString() ?? '') ?? 0;

int? _intOrNull(Object? v) => int.tryParse(v?.toString() ?? '');

/// `ComplianceStatusDto` (`Compliance/GetStatus`): the year's meetings against the
/// committee's rule, and each member's attendance. A plain member gets only their own row.
class ComplianceStatus {
  const ComplianceStatus({
    required this.committeeId,
    required this.year,
    required this.rule,
    required this.meetingsHeld,
    required this.meetingsScheduled,
    required this.meetingsCanceled,
    required this.meetingsPostponed,
    required this.meetingsMissing,
    required this.meetingsOnTrack,
    required this.meetingsLevel,
    required this.members,
    required this.membersWarning,
    required this.membersReached,
  });

  final String committeeId;
  final int year;
  final ComplianceRule rule;
  final int meetingsHeld;
  final int meetingsScheduled;
  final int meetingsCanceled;
  final int meetingsPostponed;

  /// Meetings still needed to reach the yearly minimum.
  final int meetingsMissing;
  final bool meetingsOnTrack;
  final ComplianceLevel meetingsLevel;
  final List<ComplianceMember> members;
  final int membersWarning;
  final int membersReached;

  bool get isEmpty => committeeId.isEmpty;

  /// Over the limit, then warned, then by most absences.
  List<ComplianceMember> get atRisk =>
      members.where((e) => e.level != ComplianceLevel.ok).toList()
        ..sort((a, b) {
          if (a.level != b.level) return b.level.index.compareTo(a.level.index);
          return b.absences.compareTo(a.absences);
        });

  static const empty = ComplianceStatus(
    committeeId: '',
    year: 0,
    rule: ComplianceRule.none,
    meetingsHeld: 0,
    meetingsScheduled: 0,
    meetingsCanceled: 0,
    meetingsPostponed: 0,
    meetingsMissing: 0,
    meetingsOnTrack: true,
    meetingsLevel: ComplianceLevel.ok,
    members: [],
    membersWarning: 0,
    membersReached: 0,
  );

  factory ComplianceStatus.fromJson(Map<String, dynamic> json) {
    final members = json['members'] is List ? json['members'] as List : const [];
    return ComplianceStatus(
      committeeId: json['committeeId']?.toString() ?? '',
      year: _int(json['year']),
      rule: json['rule'] is Map<String, dynamic> ? ComplianceRule.fromJson(json['rule']) : ComplianceRule.none,
      meetingsHeld: _int(json['meetingsHeld']),
      meetingsScheduled: _int(json['meetingsScheduled']),
      meetingsCanceled: _int(json['meetingsCanceled']),
      meetingsPostponed: _int(json['meetingsPostponed']),
      meetingsMissing: _int(json['meetingsMissing']),
      meetingsOnTrack: json['meetingsOnTrack'] != false,
      meetingsLevel: ComplianceLevel.fromIndex(json['meetingsLevel']),
      members: members.whereType<Map<String, dynamic>>().map(ComplianceMember.fromJson).toList(),
      membersWarning: _int(json['membersWarning']),
      membersReached: _int(json['membersReached']),
    );
  }
}

/// `ComplianceRuleDto`.
class ComplianceRule {
  const ComplianceRule({
    required this.hasRule,
    required this.minMeetingsPerYear,
    required this.maxAbsencesInRow,
    required this.maxAbsencesPerYear,
  });

  final bool hasRule;
  final int? minMeetingsPerYear;
  final int? maxAbsencesInRow;
  final int? maxAbsencesPerYear;

  static const none = ComplianceRule(
    hasRule: false,
    minMeetingsPerYear: null,
    maxAbsencesInRow: null,
    maxAbsencesPerYear: null,
  );

  factory ComplianceRule.fromJson(Map<String, dynamic> json) {
    return ComplianceRule(
      hasRule: json['hasRule'] == true,
      minMeetingsPerYear: _intOrNull(json['minMeetingsPerYear']),
      maxAbsencesInRow: _intOrNull(json['maxAbsencesInRow']),
      maxAbsencesPerYear: _intOrNull(json['maxAbsencesPerYear']),
    );
  }
}

/// `ComplianceMemberDto`.
class ComplianceMember {
  const ComplianceMember({
    required this.partyId,
    required this.name,
    required this.membershipType,
    required this.invited,
    required this.attended,
    required this.absences,
    required this.excused,
    required this.absencesInRow,
    required this.attendanceRate,
    required this.level,
  });

  final String partyId;
  final String name;
  final MembershipType membershipType;
  final int invited;
  final int attended;
  final int absences;
  final int excused;
  final int absencesInRow;

  /// Percent, null before any meeting.
  final int? attendanceRate;
  final ComplianceLevel level;

  factory ComplianceMember.fromJson(Map<String, dynamic> json) {
    final type = _int(json['membershipType']);
    return ComplianceMember(
      partyId: json['partyId']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      membershipType: type >= 0 && type < MembershipType.values.length ? MembershipType.values[type] : MembershipType.member,
      invited: _int(json['invited']),
      attended: _int(json['attended']),
      absences: _int(json['absences']),
      excused: _int(json['excused']),
      absencesInRow: _int(json['absencesInRow']),
      attendanceRate: _intOrNull(json['attendanceRate']),
      level: ComplianceLevel.fromIndex(json['level']),
    );
  }
}
