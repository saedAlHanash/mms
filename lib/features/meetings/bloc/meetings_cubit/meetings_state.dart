part of 'meetings_cubit.dart';

class MeetingsInitial extends AbstractState<List<Meeting>> {
  final Map<int, List<Meeting>> events;

  const MeetingsInitial({
    required super.result,
    super.filterRequest,
    super.error,
    required this.events,
    super.statuses,
  }); //

  factory MeetingsInitial.initial() {
    return MeetingsInitial(
      result: [],
      error: '',
      events: {},
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [
        statuses,
        result,
        error,
        filterRequest!,
        events,
      ];

  MeetingsInitial copyWith({
    CubitStatuses? statuses,
    List<Meeting>? result,
    FilterRequest? filterRequest,
    String? error,
    Map<int, List<Meeting>>? events,
  }) {
    return MeetingsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      events: events ?? this.events,
      filterRequest: filterRequest ?? this.filterRequest,
    );
  }
}
