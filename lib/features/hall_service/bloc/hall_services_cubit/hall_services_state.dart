part of 'hall_services_cubit.dart';

class HallServicesInitial extends AbstractState<List<HallServiceRequest>> {
  const HallServicesInitial({
    required super.result,
    super.error,
    super.statuses,
    required this.meetingId,
    required this.sending,
    required this.cancellingId,
  });

  final String meetingId;

  /// An add is on its way.
  final bool sending;

  /// The request being cancelled, or ''.
  final String cancellingId;

  factory HallServicesInitial.initial() {
    return const HallServicesInitial(
      result: [],
      error: '',
      statuses: CubitStatuses.init,
      meetingId: '',
      sending: false,
      cancellingId: '',
    );
  }

  @override
  List<Object> get props => [statuses, result, error, meetingId, sending, cancellingId];

  HallServicesInitial copyWith({
    CubitStatuses? statuses,
    List<HallServiceRequest>? result,
    String? error,
    String? meetingId,
    bool? sending,
    String? cancellingId,
  }) {
    return HallServicesInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      meetingId: meetingId ?? this.meetingId,
      sending: sending ?? this.sending,
      cancellingId: cancellingId ?? this.cancellingId,
    );
  }
}
