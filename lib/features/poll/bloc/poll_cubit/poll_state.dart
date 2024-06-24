part of 'poll_cubit.dart';

class PollInitial extends AbstractState<Poll> {
  const PollInitial({
    required super.result,
    super.error,
    required super.request,
    super.statuses,
  });

  factory PollInitial.initial() {
    return PollInitial(
      result: Poll.fromJson({}),
      error: '',
      request: '',
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

  PollInitial copyWith({
    CubitStatuses? statuses,
    Poll? result,
    String? error,
    String? request,
  }) {
    return PollInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
