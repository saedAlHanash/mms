part of 'check_in_code_cubit.dart';

class CheckInCodeInitial extends AbstractState<CheckInCode> {
  const CheckInCodeInitial({
    required super.result,
    super.error,
    super.statuses,
    required this.meetingId,
    required this.fetchedAt,
  });

  final String meetingId;

  /// Device time when [result] arrived; the countdown runs from it.
  final DateTime fetchedAt;

  factory CheckInCodeInitial.initial() {
    return CheckInCodeInitial(
      result: CheckInCode.empty(),
      error: '',
      statuses: CubitStatuses.init,
      meetingId: '',
      fetchedAt: DateTime.now(),
    );
  }

  @override
  List<Object> get props => [statuses, result, error, meetingId, fetchedAt];

  CheckInCodeInitial copyWith({
    CubitStatuses? statuses,
    CheckInCode? result,
    String? error,
    String? meetingId,
    DateTime? fetchedAt,
  }) {
    return CheckInCodeInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      meetingId: meetingId ?? this.meetingId,
      fetchedAt: fetchedAt ?? this.fetchedAt,
    );
  }
}
