import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/strings/enum_manager.dart';

int _int(Object? v) => int.tryParse(v?.toString() ?? '') ?? 0;

Map<String, dynamic> _unwrap(Map<String, dynamic> json) =>
    json['data'] is Map<String, dynamic> ? json['data'] as Map<String, dynamic> : json;

/// `WorkloadDto`: published tasks per member of a committee. A plain member
/// gets only their own row; the secretary, the chair and admins get everyone.
class Workload {
  const Workload({
    required this.committeeId,
    required this.members,
    required this.openTasks,
    required this.overdueTasks,
    required this.unassigned,
  });

  final String committeeId;
  final List<WorkloadRow> members;
  final int openTasks;
  final int overdueTasks;
  final int unassigned;

  bool get isEmpty => committeeId.isEmpty && members.isEmpty;

  /// Only my own row came back.
  bool get onlyMine => members.length == 1 && members.first.isMe;

  factory Workload.empty() => Workload.fromJson(const {});

  factory Workload.fromJson(Map<String, dynamic> json) {
    final map = _unwrap(json);
    final rows = map['members'] is List ? map['members'] as List : const [];
    return Workload(
      committeeId: map['committeeId'] ?? '',
      members: rows.whereType<Map<String, dynamic>>().map(WorkloadRow.fromJson).toList()
        // Busiest first.
        ..sort((a, b) {
          final byOverdue = b.overdue.compareTo(a.overdue);
          return byOverdue != 0 ? byOverdue : b.open.compareTo(a.open);
        }),
      openTasks: _int(map['openTasks']),
      overdueTasks: _int(map['overdueTasks']),
      unassigned: _int(map['unassigned']),
    );
  }
}

/// `WorkloadRowDto`.
class WorkloadRow {
  const WorkloadRow({
    required this.partyId,
    required this.name,
    required this.membershipType,
    required this.open,
    required this.overdue,
    required this.dueSoon,
    required this.completedThisYear,
  });

  final String partyId;
  final String name;
  final MembershipType membershipType;
  final int open;
  final int overdue;

  /// Due within 7 days.
  final int dueSoon;
  final int completedThisYear;

  bool get isMe => partyId.isNotEmpty && partyId == AppProvider.getParty.id;

  factory WorkloadRow.fromJson(Map<String, dynamic> json) {
    final type = _int(json['membershipType']);
    return WorkloadRow(
      partyId: json['partyId'] ?? '',
      name: json['name'] ?? '',
      membershipType: type < MembershipType.values.length ? MembershipType.values[type] : MembershipType.member,
      open: _int(json['open']),
      overdue: _int(json['overdue']),
      dueSoon: _int(json['dueSoon']),
      completedThisYear: _int(json['completedThisYear']),
    );
  }
}

/// `WorkloadTaskDto`.
class WorkloadTask {
  const WorkloadTask({
    required this.id,
    required this.name,
    required this.code,
    required this.status,
    required this.dueDate,
    required this.overdue,
    required this.meetingId,
  });

  final String id;
  final String name;
  final String code;
  final MeetingTaskStatus status;
  final DateTime? dueDate;
  final bool overdue;
  final String meetingId;

  factory WorkloadTask.fromJson(Map<String, dynamic> json) => WorkloadTask(
    id: json['id'] ?? '',
    name: json['name'] ?? '',
    code: json['code']?.toString() ?? '',
    status: MeetingTaskStatus.fromIndex(json['taskStatus']),
    dueDate: DateTime.tryParse(json['dueDate']?.toString() ?? '')?.toLocal(),
    overdue: json['overdue'] ?? false,
    meetingId: json['meetingId'] ?? '',
  );
}
