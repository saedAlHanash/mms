part of 'review_agenda_requests_cubit.dart';

class ReviewAgendaRequestsInitial extends AbstractState<List<AgendaItemRequest>> {
  const ReviewAgendaRequestsInitial({
    required super.result,
    super.error,
    super.statuses,
    required this.meetingId,
    required this.busyId,
  });

  final String meetingId;

  /// The proposal being accepted / rejected, or ''.
  final String busyId;

  int get pendingCount => result.where((e) => e.status == AgendaRequestStatus.pending).length;

  factory ReviewAgendaRequestsInitial.initial() {
    return const ReviewAgendaRequestsInitial(
      result: [],
      error: '',
      statuses: CubitStatuses.init,
      meetingId: '',
      busyId: '',
    );
  }

  @override
  List<Object> get props => [statuses, result, error, meetingId, busyId];

  ReviewAgendaRequestsInitial copyWith({
    CubitStatuses? statuses,
    List<AgendaItemRequest>? result,
    String? error,
    String? meetingId,
    String? busyId,
  }) {
    return ReviewAgendaRequestsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      meetingId: meetingId ?? this.meetingId,
      busyId: busyId ?? this.busyId,
    );
  }
}
