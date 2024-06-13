part of 'forget_password_cubit.dart';

class ForgetPasswordInitial extends AbstractState<bool> {
  final TextEditingController phoneC;

  const ForgetPasswordInitial({
    required this.phoneC,
    required super.result,
    super.error,
    super.statuses,
  });

  factory ForgetPasswordInitial.initial() {
    return ForgetPasswordInitial(
      result: false,
      error: '',
      statuses: CubitStatuses.init,
      phoneC: TextEditingController(),
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  ForgetPasswordInitial copyWith({
    TextEditingController? phoneC,
    CubitStatuses? statuses,
    bool? result,
    String? error,
  }) {
    return ForgetPasswordInitial(
      phoneC: phoneC ?? this.phoneC,
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
