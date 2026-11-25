part of 'recommendations_cubit.dart';

class RecommendationsInitial extends AbstractState<List<Recommendation>> {
  const RecommendationsInitial({
    required super.result,
    super.error,
    super.statuses,
    required this.committeeId,
    required this.tree,
    required this.sending,
    required this.busyId,
  });

  final String committeeId;
  final CommitteeTree tree;

  /// A raise is on its way.
  final bool sending;

  /// The recommendation being answered / withdrawn, or ''.
  final String busyId;

  /// Raised by this committee to its parent.
  List<Recommendation> get sent => result.where((e) => e.committeeId == committeeId).toList();

  /// Received from this committee's sub-committees.
  List<Recommendation> get received => result.where((e) => e.committeeId != committeeId).toList();

  factory RecommendationsInitial.initial() {
    return RecommendationsInitial(
      result: const [],
      error: '',
      statuses: CubitStatuses.init,
      committeeId: '',
      tree: CommitteeTree.empty(),
      sending: false,
      busyId: '',
    );
  }

  @override
  List<Object> get props => [statuses, result, error, committeeId, tree, sending, busyId];

  RecommendationsInitial copyWith({
    CubitStatuses? statuses,
    List<Recommendation>? result,
    String? error,
    String? committeeId,
    CommitteeTree? tree,
    bool? sending,
    String? busyId,
  }) {
    return RecommendationsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      committeeId: committeeId ?? this.committeeId,
      tree: tree ?? this.tree,
      sending: sending ?? this.sending,
      busyId: busyId ?? this.busyId,
    );
  }
}
