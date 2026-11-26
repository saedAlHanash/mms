part of 'decision_reservation_cubit.dart';

class DecisionReservationInitial extends AbstractState<bool> {
  const DecisionReservationInitial({
    required super.result,
    super.error,
    super.statuses,
    required this.busyId,
  });

  /// The decision being reserved on / withdrawn, or ''.
  final String busyId;

  factory DecisionReservationInitial.initial() {
    return const DecisionReservationInitial(result: false, error: '', statuses: CubitStatuses.init, busyId: '');
  }

  @override
  List<Object> get props => [statuses, result, error, busyId];

  DecisionReservationInitial copyWith({CubitStatuses? statuses, bool? result, String? error, String? busyId}) {
    return DecisionReservationInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      busyId: busyId ?? this.busyId,
    );
  }
}
