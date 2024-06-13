part of 'create_vote_cubit.dart';

class CreateVoteInitial extends AbstractState<Vote> {
  const CreateVoteInitial({
    required super.result,
    super.error,
    required super.request,
    super.statuses,
  }); //

  CreateVoteRequest get mRequest => request;

  factory CreateVoteInitial.initial() {
    return CreateVoteInitial(
      result: Vote.fromJson({}),
      error: '',
      request: CreateVoteRequest.fromJson({}),
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

  CreateVoteInitial copyWith({
    CubitStatuses? statuses,
    Vote? result,
    String? error,
    CreateVoteRequest? request,
  }) {
    return CreateVoteInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
