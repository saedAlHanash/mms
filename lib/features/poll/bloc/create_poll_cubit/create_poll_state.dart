part of 'create_poll_cubit.dart';

class CreatePollInitial extends AbstractState<Poll> {
  const CreatePollInitial({
    required super.result,
    super.error,
    required super.request,
    super.statuses,
  }); //

  CreatePollRequest get mRequest => request;

  factory CreatePollInitial.initial() {
    return CreatePollInitial(
      result: Poll.fromJson({}),
      error: '',
      request: CreatePollRequest.fromJson({}),
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

  CreatePollInitial copyWith({
    CubitStatuses? statuses,
    Poll? result,
    String? error,
    CreatePollRequest? request,
  }) {
    return CreatePollInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
