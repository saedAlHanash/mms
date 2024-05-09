part of 'logout_cubit.dart';

class LogoutInitial extends Equatable {
  final CubitStatuses statuses;
  final bool result;
  final String error;

  const LogoutInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory LogoutInitial.initial() {
    return const LogoutInitial(
      result: false,
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  LogoutInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
  }) {
    return LogoutInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
