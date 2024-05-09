part of 'reset_password_cubit.dart';

class ResetPasswordInitial extends AbstractCubit<bool> {
  final ResetPasswordRequest request;

  const ResetPasswordInitial({
    required super.result,
    super.error,
    super.statuses,
    required this.request,
  });

  factory ResetPasswordInitial.initial() {
    return ResetPasswordInitial(result: false, request: ResetPasswordRequest());
  }

  @override
  List<Object> get props => [statuses, result, error];

  ResetPasswordInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    ResetPasswordRequest? request,
  }) {
    return ResetPasswordInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
