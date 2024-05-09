part of 'otp_password_cubit.dart';

class OtpPasswordInitial extends AbstractCubit<bool> {
  final LoginRequest request;

  const OtpPasswordInitial({
    required super.result,
    super.error,
    super.statuses,
    required this.request,
  });

  factory OtpPasswordInitial.initial() {
    return OtpPasswordInitial(
      result: false,
      request: LoginRequest(),
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  OtpPasswordInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    LoginRequest? request,
  }) {
    return OtpPasswordInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
