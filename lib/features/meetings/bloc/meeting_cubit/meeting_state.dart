part of 'meeting_cubit.dart';

class MeetingInitial extends AbstractCubit<Meeting> {
  // final MeetingRequest request;
  // final bool meetingParam;


  const MeetingInitial({
    required super.result,

    super.error,
    // required this.request,
    // required this.meetingParam,
    super.statuses,
  });

  factory MeetingInitial.initial() {
    return MeetingInitial(

      result: Meeting.fromJson({}),
      error: '',
      // meetingParam: false,
      // request: MeetingRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  MeetingInitial copyWith({
    CubitStatuses? statuses,
    Meeting? result,
    String? error,

    // MeetingRequest? request,
    // bool? meetingParam,
  }) {
    return MeetingInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,

      // request: request ?? this.request,
      // meetingParam: meetingParam ?? this.meetingParam,
    );
  }
}
