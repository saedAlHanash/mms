part of 'votes_cubit.dart';

class VotesInitial extends AbstractState<List<Vote>> {
  final FilterRequest filterRequest;

  const VotesInitial({
    required super.result,
    super.error,
    super.request,
    required this.filterRequest,
    super.statuses,
  }); //

  factory VotesInitial.initial() {
    return  VotesInitial(
      result: [],
      error: '',
      filterRequest: FilterRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [
        statuses,
        result,
        error,
        if (request != null) request,
        filterRequest!,
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
