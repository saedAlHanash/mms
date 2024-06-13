part of 'votes_cubit.dart';

class VotesInitial extends AbstractState<List<Vote>> {
  const VotesInitial({
    required super.result,
    super.error,
    super.request,
    super.filterRequest,
    super.statuses,
  }); //

  factory VotesInitial.initial() {
    return const VotesInitial(
      result: [],
      error: '',
      filterRequest: null,
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [
        statuses,
        result,
        error,
        if (request != null) request,
        if (filterRequest != null) filterRequest!
      ];

  VotesInitial copyWith({
    CubitStatuses? statuses,
    List<Vote>? result,
    String? error,
    FilterRequest? filterRequest,
    dynamic request,
  }) {
    return VotesInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      filterRequest: filterRequest ?? this.filterRequest,
      request: request ?? this.request,
    );
  }
}
