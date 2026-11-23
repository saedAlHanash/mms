part of 'check_in_cubit.dart';

class CheckInInitial extends AbstractState<CheckInResult> {
  const CheckInInitial({required super.result, super.error, super.statuses});

  factory CheckInInitial.initial() {
    return CheckInInitial(result: CheckInResult.empty(), error: '', statuses: CubitStatuses.init);
  }

  @override
  List<Object> get props => [statuses, result, error];

  CheckInInitial copyWith({CubitStatuses? statuses, CheckInResult? result, String? error}) {
    return CheckInInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}
