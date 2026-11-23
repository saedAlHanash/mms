part of 'meeting_interests_cubit.dart';

class MeetingInterestsInitial extends AbstractState<List<InterestDisclosure>> {
  const MeetingInterestsInitial({
    required super.result,
    super.error,
    super.statuses,
    required this.meetingId,
    required this.sendingItemId,
  });

  final String meetingId;

  /// The agenda item being declared or withdrawn, for its loading state.
  final String sendingItemId;

  factory MeetingInterestsInitial.initial() {
    return const MeetingInterestsInitial(
      result: [],
      error: '',
      statuses: CubitStatuses.init,
      meetingId: '',
      sendingItemId: '',
    );
  }

  @override
  List<Object> get props => [statuses, result, error, meetingId, sendingItemId];

  MeetingInterestsInitial copyWith({
    CubitStatuses? statuses,
    List<InterestDisclosure>? result,
    String? error,
    String? meetingId,
    String? sendingItemId,
  }) {
    return MeetingInterestsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      meetingId: meetingId ?? this.meetingId,
      sendingItemId: sendingItemId ?? this.sendingItemId,
    );
  }
}
