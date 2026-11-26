import 'package:mms/core/strings/enum_manager.dart';

int _int(Object? v) => int.tryParse(v?.toString() ?? '') ?? 0;

int? _intOrNull(Object? v) => int.tryParse(v?.toString() ?? '');

DateTime? _date(Object? v) => DateTime.tryParse(v?.toString() ?? '')?.toLocal();

List<T> _list<T>(Object? v, T Function(Map<String, dynamic>) fromJson) =>
    v is List ? v.whereType<Map<String, dynamic>>().map(fromJson).toList() : <T>[];

/// `AnnualReportDto` (`Executive/GetAnnualReport`): a committee's year, built live.
/// For the chair, the secretary and admins.
class AnnualReport {
  const AnnualReport({
    required this.committeeId,
    required this.name,
    required this.year,
    required this.generatedAt,
    required this.summary,
    required this.meetings,
    required this.decisions,
    required this.circulations,
  });

  final String committeeId;
  final String name;
  final int year;
  final DateTime? generatedAt;
  final AnnualSummary summary;
  final List<AnnualMeeting> meetings;
  final List<AnnualDecision> decisions;
  final List<AnnualCirculation> circulations;

  bool get isEmpty => committeeId.isEmpty;

  static const empty = AnnualReport(
    committeeId: '',
    name: '',
    year: 0,
    generatedAt: null,
    summary: AnnualSummary.empty,
    meetings: [],
    decisions: [],
    circulations: [],
  );

  factory AnnualReport.fromJson(Map<String, dynamic> json) {
    return AnnualReport(
      committeeId: json['committeeId']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      year: _int(json['year']),
      generatedAt: _date(json['generatedAt']),
      summary: json['summary'] is Map<String, dynamic> ? AnnualSummary.fromJson(json['summary']) : AnnualSummary.empty,
      meetings: _list(json['meetings'], AnnualMeeting.fromJson),
      decisions: _list(json['decisions'], AnnualDecision.fromJson),
      circulations: _list(json['circulations'], AnnualCirculation.fromJson),
    );
  }
}

/// `ExecutiveCommitteeDto`: the year's figures.
class AnnualSummary {
  const AnnualSummary({
    required this.minMeetings,
    required this.meetingsHeld,
    required this.meetingsScheduled,
    required this.meetingsLevel,
    required this.attendanceRate,
    required this.membersAtLimit,
    required this.decisions,
    required this.decisionsDone,
    required this.decisionsOverdue,
    required this.executionRate,
    required this.openTasks,
    required this.overdueTasks,
    required this.circulationsApproved,
  });

  final int? minMeetings;
  final int meetingsHeld;
  final int meetingsScheduled;
  final ComplianceLevel meetingsLevel;
  final int? attendanceRate;
  final int membersAtLimit;
  final int decisions;
  final int decisionsDone;
  final int decisionsOverdue;

  /// Percent of decisions carried out (through their tasks).
  final int? executionRate;
  final int openTasks;
  final int overdueTasks;
  final int circulationsApproved;

  static const empty = AnnualSummary(
    minMeetings: null,
    meetingsHeld: 0,
    meetingsScheduled: 0,
    meetingsLevel: ComplianceLevel.ok,
    attendanceRate: null,
    membersAtLimit: 0,
    decisions: 0,
    decisionsDone: 0,
    decisionsOverdue: 0,
    executionRate: null,
    openTasks: 0,
    overdueTasks: 0,
    circulationsApproved: 0,
  );

  factory AnnualSummary.fromJson(Map<String, dynamic> json) {
    return AnnualSummary(
      minMeetings: _intOrNull(json['minMeetings']),
      meetingsHeld: _int(json['meetingsHeld']),
      meetingsScheduled: _int(json['meetingsScheduled']),
      meetingsLevel: ComplianceLevel.fromIndex(json['meetingsLevel']),
      attendanceRate: _intOrNull(json['attendanceRate']),
      membersAtLimit: _int(json['membersAtLimit']),
      decisions: _int(json['decisions']),
      decisionsDone: _int(json['decisionsDone']),
      decisionsOverdue: _int(json['decisionsOverdue']),
      executionRate: _intOrNull(json['executionRate']),
      openTasks: _int(json['openTasks']),
      overdueTasks: _int(json['overdueTasks']),
      circulationsApproved: _int(json['circulationsApproved']),
    );
  }
}

/// `AnnualMeetingDto`.
class AnnualMeeting {
  const AnnualMeeting({
    required this.id,
    required this.title,
    required this.fromDate,
    required this.status,
    required this.invited,
    required this.attended,
  });

  final String id;
  final String title;
  final DateTime? fromDate;
  final MeetingStatus status;
  final int invited;
  final int attended;

  factory AnnualMeeting.fromJson(Map<String, dynamic> json) {
    final i = _int(json['status']);
    return AnnualMeeting(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      fromDate: _date(json['fromDate']),
      status: i >= 0 && i < MeetingStatus.values.length ? MeetingStatus.values[i] : MeetingStatus.values.first,
      invited: _int(json['invited']),
      attended: _int(json['attended']),
    );
  }
}

/// `AnnualDecisionDto` with its `DecisionProgressDto`.
class AnnualDecision {
  const AnnualDecision({
    required this.id,
    required this.number,
    required this.year,
    required this.statement,
    required this.meetingId,
    required this.meetingTitle,
    required this.tasks,
    required this.completed,
    required this.overdue,
    required this.progress,
  });

  final String id;
  final int? number;
  final int? year;
  final String statement;
  final String meetingId;
  final String meetingTitle;
  final int tasks;
  final int completed;
  final int overdue;

  /// Percent done.
  final int progress;

  String get numberLabel => number == null || year == null ? '' : '$number/$year';

  factory AnnualDecision.fromJson(Map<String, dynamic> json) {
    final p = json['progress'] is Map ? json['progress'] as Map : const {};
    return AnnualDecision(
      id: json['id']?.toString() ?? '',
      number: _intOrNull(json['number']),
      year: _intOrNull(json['year']),
      statement: json['statement']?.toString() ?? '',
      meetingId: json['meetingId']?.toString() ?? '',
      meetingTitle: json['meetingTitle']?.toString() ?? '',
      tasks: _int(p['tasks']),
      completed: _int(p['completed']),
      overdue: _int(p['overdue']),
      progress: _int(p['progress']).clamp(0, 100),
    );
  }
}

/// `AnnualCirculationDto`.
class AnnualCirculation {
  const AnnualCirculation({
    required this.id,
    required this.number,
    required this.year,
    required this.title,
    required this.outcome,
  });

  final String id;
  final int? number;
  final int? year;
  final String title;
  final CirculationOutcome? outcome;

  String get numberLabel => number == null || year == null ? '' : '$number/$year';

  factory AnnualCirculation.fromJson(Map<String, dynamic> json) {
    return AnnualCirculation(
      id: json['id']?.toString() ?? '',
      number: _intOrNull(json['number']),
      year: _intOrNull(json['year']),
      title: json['title']?.toString() ?? '',
      outcome: CirculationOutcome.fromIndex(json['outcome']),
    );
  }
}
