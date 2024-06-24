part of 'polls_cubit.dart';

class PollsInitial extends AbstractState<List<Poll>> {
  const PollsInitial({
    required super.result,
    super.error,
    super.request,
    super.filterRequest,
    super.statuses,
  }); //

  factory PollsInitial.initial() {
    return const PollsInitial(
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

  PollsInitial copyWith({
    CubitStatuses? statuses,
    List<Poll>? result,
    String? error,
    FilterRequest? filterRequest,
    dynamic request,
  }) {
    return PollsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      filterRequest: filterRequest ?? this.filterRequest,
      request: request ?? this.request,
    );
  }
}
