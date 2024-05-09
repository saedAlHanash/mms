part of 'confirm_code_cubit.dart';

class ConfirmCodeInitial extends AbstractCubit<LoginResponse> {
  final LoginRequest request;

  const ConfirmCodeInitial({
    required super.result,
    super.error,
    super.statuses,
    required this.request,
  });

  factory ConfirmCodeInitial.initial() {
    return ConfirmCodeInitial(
      result: LoginResponse.fromJson({}),
      request: LoginRequest(),
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  ConfirmCodeInitial copyWith({
    CubitStatuses? statuses,
    LoginResponse? result,
    String? error,
    LoginRequest? request,
  }) {
    return ConfirmCodeInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
