part of 'delete_temp_cubit.dart';

class DeleteTempInitial extends AbstractState<bool> {
  const DeleteTempInitial({
    required super.result,
    super.error,
    required super.request,
    super.statuses,
  }); //

  factory DeleteTempInitial.initial() {
    return const DeleteTempInitial(
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
  DeleteTempInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    String? request,
  }) {
    return DeleteTempInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
