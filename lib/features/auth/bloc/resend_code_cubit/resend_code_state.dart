part of 'resend_code_cubit.dart';

class ResendCodeInitial extends AbstractCubit<String> {


  const ResendCodeInitial({
    required super.result,
    super.error,
    super.statuses,
  });

  factory ResendCodeInitial.initial() {
    return const ResendCodeInitial(
      result: '',
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  ResendCodeInitial copyWith({
    CubitStatuses? statuses,
    String? result,
    String? error,
  }) {
    return ResendCodeInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }

}