/// `MinuteApprovalPathDto` (`Minute/GetApprovalPath`).
class MinuteApprovalPath {
  const MinuteApprovalPath({
    required this.minuteId,
    required this.approvalDeadline,
    required this.chairApprovesLast,
    required this.closed,
    required this.isFinal,
    required this.approvers,
    required this.approved,
    required this.rejected,
    required this.pending,
    required this.chairPartyId,
    required this.chairApproved,
    required this.chairsTurn,
    required this.canFinalize,
    required this.blockers,
  });

  final String minuteId;
  final DateTime? approvalDeadline;
  final bool chairApprovesLast;

  /// The deadline passed: no more answers.
  final bool closed;

  /// The minutes are confirmed.
  final bool isFinal;
  final int approvers;
  final int approved;
  final int rejected;
  final int pending;
  final String chairPartyId;
  final bool chairApproved;

  /// Everyone else answered; the chair may approve now.
  final bool chairsTurn;
  final bool canFinalize;

  /// "rejected", "pending" or "chair".
  final List<String> blockers;

  /// Answers are still taken.
  bool get open => !closed && !isFinal;

  factory MinuteApprovalPath.fromJson(Map<String, dynamic> json) {
    int n(Object? v) => int.tryParse(v?.toString() ?? '') ?? 0;
    return MinuteApprovalPath(
      minuteId: json['minuteId']?.toString() ?? '',
      approvalDeadline: DateTime.tryParse(json['approvalDeadline']?.toString() ?? '')?.toLocal(),
      chairApprovesLast: json['chairApprovesLast'] == true,
      closed: json['closed'] == true,
      isFinal: json['final'] == true,
      approvers: n(json['approvers']),
      approved: n(json['approved']),
      rejected: n(json['rejected']),
      pending: n(json['pending']),
      chairPartyId: json['chairPartyId']?.toString() ?? '',
      chairApproved: json['chairApproved'] == true,
      chairsTurn: json['chairsTurn'] == true,
      canFinalize: json['canFinalize'] == true,
      blockers: json['blockers'] is List ? [for (final e in json['blockers'] as List) e.toString()] : const [],
    );
  }
}

/// One approver's answer (`Minute/GetMinuteApprovals`, `Minute/GetPartyApproval`).
/// [isApproved] is null while they haven't answered.
class MinuteApproval {
  const MinuteApproval({required this.partyId, required this.name, required this.isApproved, required this.reason});

  final String partyId;
  final String name;
  final bool? isApproved;
  final String reason;

  factory MinuteApproval.fromJson(Map<String, dynamic> json) {
    final party = json['party'] is Map<String, dynamic> ? json['party'] as Map<String, dynamic> : const {};
    String str(Object? v) => v?.toString().trim() ?? '';
    final parts = [party['firstName'], party['middleName'], party['lastName']].map(str).where((e) => e.isNotEmpty);
    final name = [json['name'], json['partyName'], json['fullName']]
        .map(str)
        .firstWhere((e) => e.isNotEmpty, orElse: () => parts.join(' '));
    final approved = json['isApproved'] ?? json['approved'];
    return MinuteApproval(
      partyId: str(json['partyId'] ?? party['id']),
      name: name,
      isApproved: approved is bool ? approved : null,
      reason: str(json['reason']),
    );
  }
}
