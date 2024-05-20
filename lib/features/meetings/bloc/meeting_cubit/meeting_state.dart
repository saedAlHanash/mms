part of 'meeting_cubit.dart';

class MeetingInitial extends AbstractCubit<Meeting> {
  final String id;

  // final bool meetingParam;

  const MeetingInitial({
    required super.result,
    super.error,
    required this.id,
    // required this.meetingParam,
    super.statuses,
  });

  factory MeetingInitial.initial() {
    return MeetingInitial(
      result: Meeting.fromJson({}),
      error: '',
      // meetingParam: false,
      id: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error, id];

  MeetingInitial copyWith({
    CubitStatuses? statuses,
    Meeting? result,
    String? error,
    String? id,
    // bool? meetingParam,
  }) {
    return MeetingInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,

      id: id ?? this.id,
      // meetingParam: meetingParam ?? this.meetingParam,
    );
  }
}
