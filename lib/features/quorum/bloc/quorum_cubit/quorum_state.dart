part of 'quorum_cubit.dart';

class QuorumInitial extends AbstractState<MeetingQuorum> {
  const QuorumInitial({
    required super.result,
    super.error,
    super.statuses,
    required this.meetingId,
  });

  final String meetingId;

  factory QuorumInitial.initial() {
    return QuorumInitial(
      result: MeetingQuorum.empty(),
      error: '',
      statuses: CubitStatuses.init,
      meetingId: '',
    );
  }

  @override
  List<Object> get props => [statuses, result, error, meetingId];

  QuorumInitial copyWith({
    CubitStatuses? statuses,
    MeetingQuorum? result,
    String? error,
    String? meetingId,
  }) {
    return QuorumInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      meetingId: meetingId ?? this.meetingId,
    );
  }
}
