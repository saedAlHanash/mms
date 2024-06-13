part of 'vote_cubit.dart';

class VoteInitial extends AbstractState<Vote> {



  const VoteInitial({
    required super.result,
    super.error,
    required super.request,
    // required this.voteParam,
    super.statuses,
  });

  factory VoteInitial.initial() {
    return VoteInitial(
      result: Vote.fromJson({}),
      error: '',
      // voteParam: false,
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

  VoteInitial copyWith({
    CubitStatuses? statuses,
    Vote? result,
    String? error,
    String? request,
    // bool? voteParam,
  }) {
    return VoteInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
      // voteParam: voteParam ?? this.voteParam,
    );
  }
}
