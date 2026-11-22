part of 'meeting_live_cubit.dart';

class MeetingLiveInitial extends AbstractState<MeetingLiveState> {
  const MeetingLiveInitial({
    required super.result,
    super.error,
    super.statuses,
    required this.meetingId,
    required this.fetchedAt,
    required this.sending,
  });

  final String meetingId;

  /// Device time when [result] arrived; the clocks tick from it.
  final DateTime fetchedAt;

  /// A floor request / withdraw is on its way.
  final bool sending;

  factory MeetingLiveInitial.initial() {
    return MeetingLiveInitial(
      result: MeetingLiveState.empty(),
      error: '',
      statuses: CubitStatuses.init,
      meetingId: '',
      fetchedAt: DateTime.now(),
      sending: false,
    );
  }

  @override
  List<Object> get props => [statuses, result, error, meetingId, fetchedAt, sending];

  MeetingLiveInitial copyWith({
    CubitStatuses? statuses,
    MeetingLiveState? result,
    String? error,
    String? meetingId,
    DateTime? fetchedAt,
    bool? sending,
  }) {
    return MeetingLiveInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      meetingId: meetingId ?? this.meetingId,
      fetchedAt: fetchedAt ?? this.fetchedAt,
      sending: sending ?? this.sending,
    );
  }
}
