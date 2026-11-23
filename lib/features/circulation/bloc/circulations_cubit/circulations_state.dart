part of 'circulations_cubit.dart';

class CirculationsInitial extends AbstractState<List<Circulation>> {
  const CirculationsInitial({
    required super.result,
    super.error,
    super.statuses,
    required this.committeeId,
    required this.statusFilter,
    required this.page,
    required this.totalCount,
    required this.loadingMore,
  });

  final String committeeId;

  /// null = all.
  final CirculationStatus? statusFilter;

  /// Last page loaded (0-based).
  final int page;
  final int totalCount;
  final bool loadingMore;

  bool get hasMore => result.length < totalCount;

  /// Open circulations still waiting for my vote (loaded so far; open ones come first).
  int get awaitingMyVote => result.where((e) => e.awaitsMyVote).length;

  factory CirculationsInitial.initial() {
    return const CirculationsInitial(
      result: [],
      error: '',
      statuses: CubitStatuses.init,
      committeeId: '',
      statusFilter: null,
      page: 0,
      totalCount: 0,
      loadingMore: false,
    );
  }

  @override
  List<Object> get props => [statuses, result, error, committeeId, statusFilter?.index ?? -1, page, totalCount, loadingMore];

  CirculationsInitial copyWith({
    CubitStatuses? statuses,
    List<Circulation>? result,
    String? error,
    String? committeeId,
    CirculationStatus? Function()? statusFilter,
    int? page,
    int? totalCount,
    bool? loadingMore,
  }) {
    return CirculationsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      committeeId: committeeId ?? this.committeeId,
      statusFilter: statusFilter != null ? statusFilter() : this.statusFilter,
      page: page ?? this.page,
      totalCount: totalCount ?? this.totalCount,
      loadingMore: loadingMore ?? this.loadingMore,
    );
  }
}
