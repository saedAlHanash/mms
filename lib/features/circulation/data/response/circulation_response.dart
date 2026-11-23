import 'package:mms/core/strings/enum_manager.dart';

/// Unwraps `{data: {...}}` when the server wraps a single result.
Map<String, dynamic> _unwrap(Map<String, dynamic> json) =>
    json['data'] is Map<String, dynamic> ? json['data'] as Map<String, dynamic> : json;

List<T> _list<T>(Object? value, T Function(Map<String, dynamic>) fromJson) =>
    value is List ? value.whereType<Map<String, dynamic>>().map(fromJson).toList() : <T>[];

int _int(Object? value) => int.tryParse(value?.toString() ?? '') ?? 0;

double _double(Object? value) => double.tryParse(value?.toString() ?? '') ?? 0;

DateTime? _date(Object? value) => DateTime.tryParse(value?.toString() ?? '')?.toLocal();

/// A decision by circulation (`CirculationDto`, and `CirculationDetailsDto`
/// when [votes] / [pendingVoters] are filled).
class Circulation {
  const Circulation({
    required this.id,
    required this.committeeId,
    required this.title,
    required this.statement,
    required this.mediaId,
    required this.mediaName,
    required this.mediaSavedPath,
    required this.status,
    required this.deadline,
    required this.deadlinePassed,
    required this.openedAt,
    required this.closedAt,
    required this.outcome,
    required this.number,
    required this.year,
    required this.created,
    required this.voters,
    required this.approved,
    required this.rejected,
    required this.abstained,
    required this.pending,
    required this.approveWeight,
    required this.totalWeight,
    required this.myChoice,
    required this.myReason,
    required this.canVote,
    required this.votes,
    required this.pendingVoters,
  });

  final String id;
  final String committeeId;
  final String title;
  final String statement;
  final String mediaId;
  final String mediaName;

  /// Not in the DTO today; read if the server adds it.
  final String mediaSavedPath;
  final CirculationStatus status;
  final DateTime? deadline;
  final bool deadlinePassed;
  final DateTime? openedAt;
  final DateTime? closedAt;
  final CirculationOutcome? outcome;
  final int? number;
  final int? year;
  final DateTime? created;

  final int voters;
  final int approved;
  final int rejected;
  final int abstained;
  final int pending;
  final double approveWeight;
  final double totalWeight;

  final CirculationChoice? myChoice;
  final String myReason;
  final bool canVote;

  final List<CirculationVote> votes;
  final List<PendingVoter> pendingVoters;

  bool get isEmpty => id.isEmpty;

  bool get hasAttachment => mediaId.isNotEmpty;

  /// Voting is possible right now.
  bool get isVotable => status == CirculationStatus.open && canVote && !deadlinePassed;

  /// Open, I can vote and haven't yet: counted in the committee badge.
  bool get awaitsMyVote => isVotable && myChoice == null;

  /// "3/2026" once approved.
  String get numberLabel => number == null
      ? ''
      : year == null
      ? '$number'
      : '$number/$year';

  factory Circulation.empty() => Circulation.fromJson(const {});

  factory Circulation.fromJson(Map<String, dynamic> json) {
    final map = _unwrap(json);
    final number = int.tryParse(map['number']?.toString() ?? '');
    final year = int.tryParse(map['year']?.toString() ?? '');
    return Circulation(
      id: map['id'] ?? '',
      committeeId: map['committeeId'] ?? '',
      title: map['title'] ?? '',
      statement: map['statement'] ?? '',
      mediaId: map['mediaId'] ?? '',
      mediaName: map['mediaName'] ?? '',
      mediaSavedPath: map['mediaSavedPath'] ?? '',
      status: CirculationStatus.fromIndex(map['status']),
      deadline: _date(map['deadline']),
      deadlinePassed: map['deadlinePassed'] ?? false,
      openedAt: _date(map['openedAt']),
      closedAt: _date(map['closedAt']),
      outcome: CirculationOutcome.fromIndex(map['outcome']),
      number: number,
      year: year,
      created: _date(map['created']),
      voters: _int(map['voters']),
      approved: _int(map['approved']),
      rejected: _int(map['rejected']),
      abstained: _int(map['abstained']),
      pending: _int(map['pending']),
      approveWeight: _double(map['approveWeight']),
      totalWeight: _double(map['totalWeight']),
      myChoice: CirculationChoice.fromIndex(map['myChoice']),
      myReason: map['myReason'] ?? '',
      canVote: map['canVote'] ?? false,
      votes: _list(map['votes'], CirculationVote.fromJson),
      pendingVoters: _list(map['pendingVoters'], PendingVoter.fromJson),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'committeeId': committeeId,
    'title': title,
    'statement': statement,
    'mediaId': mediaId,
    'mediaName': mediaName,
    'status': status.index,
    'deadline': deadline?.toIso8601String(),
    'deadlinePassed': deadlinePassed,
    'openedAt': openedAt?.toIso8601String(),
    'closedAt': closedAt?.toIso8601String(),
    'outcome': outcome?.index,
    'number': number,
    'year': year,
    'created': created?.toIso8601String(),
    'voters': voters,
    'approved': approved,
    'rejected': rejected,
    'abstained': abstained,
    'pending': pending,
    'approveWeight': approveWeight,
    'totalWeight': totalWeight,
    'myChoice': myChoice?.index,
    'myReason': myReason,
    'canVote': canVote,
    'votes': votes.map((e) => e.toJson()).toList(),
    'pendingVoters': pendingVoters.map((e) => e.toJson()).toList(),
  };
}

class CirculationVote {
  const CirculationVote({
    required this.partyId,
    required this.name,
    required this.choice,
    required this.reason,
    required this.weight,
    required this.at,
  });

  final String partyId;
  final String name;
  final CirculationChoice? choice;
  final String reason;
  final double weight;
  final DateTime? at;

  factory CirculationVote.fromJson(Map<String, dynamic> json) => CirculationVote(
    partyId: json['partyId'] ?? '',
    name: json['name'] ?? '',
    choice: CirculationChoice.fromIndex(json['choice']),
    reason: json['reason'] ?? '',
    weight: _double(json['weight']),
    at: _date(json['at']),
  );

  Map<String, dynamic> toJson() => {
    'partyId': partyId,
    'name': name,
    'choice': choice?.index,
    'reason': reason,
    'weight': weight,
    'at': at?.toIso8601String(),
  };
}

class PendingVoter {
  const PendingVoter({required this.partyId, required this.name, required this.weight});

  final String partyId;
  final String name;
  final double weight;

  factory PendingVoter.fromJson(Map<String, dynamic> json) =>
      PendingVoter(partyId: json['partyId'] ?? '', name: json['name'] ?? '', weight: _double(json['weight']));

  Map<String, dynamic> toJson() => {'partyId': partyId, 'name': name, 'weight': weight};
}

/// `CirculationListDto`.
class CirculationPage {
  const CirculationPage({required this.totalCount, required this.items});

  final int totalCount;
  final List<Circulation> items;

  factory CirculationPage.fromJson(Map<String, dynamic> json) {
    final map = _unwrap(json);
    return CirculationPage(totalCount: _int(map['totalCount']), items: _list(map['items'], Circulation.fromJson));
  }
}
