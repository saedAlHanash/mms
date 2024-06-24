part of 'delete_poll_cubit.dart';

class DeletePollInitial extends AbstractState<bool> {
  const DeletePollInitial({
    required super.result,
    super.error,
    required super.request,
    super.statuses,
  }); //

  factory DeletePollInitial.initial() {
    return const DeletePollInitial(
      result: false,
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
  DeletePollInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    String? request,
  }) {
    return DeletePollInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
