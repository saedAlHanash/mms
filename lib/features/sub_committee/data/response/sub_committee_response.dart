import 'package:mms/core/strings/enum_manager.dart';

Map<String, dynamic> _unwrap(Map<String, dynamic> json) =>
    json['data'] is Map<String, dynamic> ? json['data'] as Map<String, dynamic> : json;

List<T> _list<T>(Object? value, T Function(Map<String, dynamic>) fromJson) =>
    value is List ? value.whereType<Map<String, dynamic>>().map(fromJson).toList() : <T>[];

DateTime? _date(Object? v) => DateTime.tryParse(v?.toString() ?? '')?.toLocal();

/// `CommitteeTreeDto`: where a committee sits (its ancestors and direct children).
class CommitteeTree {
  const CommitteeTree({
    required this.committeeId,
    required this.name,
    required this.parentId,
    required this.ancestors,
    required this.children,
  });

  final String committeeId;
  final String name;
  final String parentId;

  /// From the top down to the direct parent.
  final List<CommitteeNode> ancestors;
  final List<CommitteeNode> children;

  bool get hasParent => parentId.isNotEmpty;

  CommitteeNode? get parent {
    for (final e in ancestors) {
      if (e.id == parentId) return e;
    }
    return ancestors.isEmpty ? null : ancestors.last;
  }

  factory CommitteeTree.empty() => CommitteeTree.fromJson(const {});

  factory CommitteeTree.fromJson(Map<String, dynamic> json) {
    final map = _unwrap(json);
    return CommitteeTree(
      committeeId: map['committeeId'] ?? '',
      name: map['name'] ?? '',
      parentId: map['parentId'] ?? '',
      ancestors: _list(map['ancestors'], CommitteeNode.fromJson),
      children: _list(map['children'], CommitteeNode.fromJson),
    );
  }
}

/// `CommitteeNodeDto`.
class CommitteeNode {
  const CommitteeNode({required this.id, required this.name, required this.code, required this.isActive});

  final String id;
  final String name;
  final String code;
  final bool isActive;

  factory CommitteeNode.fromJson(Map<String, dynamic> json) => CommitteeNode(
    id: json['id'] ?? '',
    name: json['name'] ?? '',
    code: json['code']?.toString() ?? '',
    isActive: json['isActive'] ?? true,
  );
}

/// `RecommendationDto`: raised by a sub-committee to its parent.
class Recommendation {
  const Recommendation({
    required this.id,
    required this.committeeId,
    required this.committeeName,
    required this.parentCommitteeId,
    required this.parentCommitteeName,
    required this.title,
    required this.body,
    required this.state,
    required this.raisedByName,
    required this.raisedAt,
    required this.respondedAt,
    required this.respondedByName,
    required this.responseNote,
  });

  final String id;

  /// The sub-committee that raised it.
  final String committeeId;
  final String committeeName;
  final String parentCommitteeId;
  final String parentCommitteeName;
  final String title;
  final String body;
  final RecommendationState state;
  final String raisedByName;
  final DateTime? raisedAt;
  final DateTime? respondedAt;
  final String respondedByName;
  final String responseNote;

  bool get isEmpty => id.isEmpty;

  bool get isPending => state == RecommendationState.pending;

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    final map = _unwrap(json);
    return Recommendation(
      id: map['id'] ?? '',
      committeeId: map['committeeId'] ?? '',
      committeeName: map['committeeName'] ?? '',
      parentCommitteeId: map['parentCommitteeId'] ?? '',
      parentCommitteeName: map['parentCommitteeName'] ?? '',
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      state: RecommendationState.fromIndex(map['state']),
      raisedByName: map['raisedByName'] ?? '',
      raisedAt: _date(map['raisedAt']),
      respondedAt: _date(map['respondedAt']),
      respondedByName: map['respondedByName'] ?? '',
      responseNote: map['responseNote'] ?? '',
    );
  }
}
