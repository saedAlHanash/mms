part of 'attendees_cubit.dart';

class AttendeesInitial extends AbstractState<List<Attendee>> {
  // final AttendeesRequest request;
  // final  bool tempParam;
  const AttendeesInitial({
    required super.result,
    super.error,
    // required this.request,
    // required this.tempParam,
    super.statuses,
  }); //

  factory AttendeesInitial.initial() {
    return const AttendeesInitial(
      result: [],
      error: '',
      // tempParam: false,
      // request: AttendeesRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  AttendeesInitial copyWith({
    CubitStatuses? statuses,
    List<Attendee>? result,
    String? error,
    // AttendeesRequest? request,
    // bool? tempParam,
  }) {
    return AttendeesInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      // request: request ?? this.request,
      // tempParam: tempParam ?? this.tempParam,
    );
  }
}
