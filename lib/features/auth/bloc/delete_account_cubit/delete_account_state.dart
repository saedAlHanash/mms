part of 'delete_account_cubit.dart';

class DeleteAccountInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final String error;

  const DeleteAccountInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory DeleteAccountInitial.initial() {
    return const DeleteAccountInitial(
      result: false,
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  DeleteAccountInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
  }) {
    return DeleteAccountInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
