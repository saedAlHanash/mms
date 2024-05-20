part of 'attendee_cubit.dart';

class AttendeeInitial extends AbstractCubit<Attendee> {
  // final AttendeeRequest request;
  // final bool tempParam;

  const AttendeeInitial({
    required super.result,
    super.error,
    // required this.request,
    // required this.tempParam,
    super.statuses,
  });

  factory AttendeeInitial.initial() {
    return AttendeeInitial(
      result: Attendee.fromJson({}),
      error: '',
      // tempParam: false,
      // request: AttendeeRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  AttendeeInitial copyWith({
    CubitStatuses? statuses,
    Attendee? result,
    String? error,
    // AttendeeRequest? request,
    // bool? tempParam,
  }) {
    return AttendeeInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      // request: request ?? this.request,
      // tempParam: tempParam ?? this.tempParam,
    );
  }
}
