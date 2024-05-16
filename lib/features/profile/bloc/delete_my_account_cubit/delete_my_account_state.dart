part of 'delete_my_account_cubit.dart';

class DeleteMyAccountInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final String error;

  const DeleteMyAccountInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory DeleteMyAccountInitial.initial() {
    return const DeleteMyAccountInitial(
      result: false,
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  DeleteMyAccountInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
  }) {
    return DeleteMyAccountInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
