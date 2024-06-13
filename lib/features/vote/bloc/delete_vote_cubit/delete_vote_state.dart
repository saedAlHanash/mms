part of 'delete_vote_cubit.dart';

class DeleteVoteInitial extends AbstractState<bool> {
  const DeleteVoteInitial({
    required super.result,
    super.error,
    required super.request,
    super.statuses,
  }); //

  factory DeleteVoteInitial.initial() {
    return const DeleteVoteInitial(
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
  DeleteVoteInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    String? request,
  }) {
    return DeleteVoteInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
