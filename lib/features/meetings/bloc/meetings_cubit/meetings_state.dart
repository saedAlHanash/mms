part of 'meetings_cubit.dart';

class MeetingsInitial extends AbstractState<List<Meeting>> {
  final Map<int, List<Meeting>> events;

  // final MeetingRequest request;
  // final  bool meetingParam;

  const MeetingsInitial({
    required super.result,
    required super.filterRequest,
    super.error,
    // required this.request,
    required this.events,
    // required this.meetingParam,
    super.statuses,
  }); //

  factory MeetingsInitial.initial() {
    return MeetingsInitial(
      result: [],
      error: '',
      events: {},
      filterRequest: FilterRequest(),
      statuses: CubitStatuses.init,
      // meetingParam: false,
      // request: MeetingRequest(),
    );
  }

  @override
  List<Object> get props => [statuses, result, error, filterRequest!];

  MeetingsInitial copyWith({
    CubitStatuses? statuses,
    List<Meeting>? result,
    FilterRequest? filterRequest,
    String? error,
    // MeetingRequest? request,
    Map<int, List<Meeting>>? events,
    // bool? meetingParam,
  }) {
    return MeetingsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      events: events ?? this.events,
      filterRequest: filterRequest ?? this.filterRequest,

      // request: request ?? this.request,
      // meetingParam: meetingParam ?? this.meetingParam,
    );
  }
}
