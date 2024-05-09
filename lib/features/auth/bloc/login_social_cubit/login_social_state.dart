part of 'login_social_cubit.dart';

class LoginSocialInitial extends AbstractCubit<LoginResponse> {
  final LoginRequest request;
 final  bool isTrainer;
  const LoginSocialInitial({
    required super.result,
    super.error,
    required this.request,
     required this.isTrainer,
    super.statuses,
  });

  factory LoginSocialInitial.initial() {
    return LoginSocialInitial(
      result: LoginResponse.fromJson({}),
      error: '',
      isTrainer: false,
      request: LoginRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error,isTrainer];

  LoginSocialInitial copyWith({
    CubitStatuses? statuses,
    LoginResponse? result,
    String? error,
    LoginRequest? request,
    bool? isTrainer,
  }) {
    return LoginSocialInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
      isTrainer: isTrainer ?? this.isTrainer,
    );
  }
}
