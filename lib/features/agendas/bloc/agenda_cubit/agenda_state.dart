part of 'agenda_cubit.dart';

class AgendaInitial extends AbstractState<Agenda> {
  // final AgendaRequest request;
  // final bool agendaParam;

  const AgendaInitial({
    required super.result,
    super.error,
    // required this.request,
    // required this.agendaParam,
    super.statuses,
  });

  factory AgendaInitial.initial() {
    return AgendaInitial(
      result: Agenda.fromJson({}),
      error: '',
      // agendaParam: false,
      // request: AgendaRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  AgendaInitial copyWith({
    CubitStatuses? statuses,
    Agenda? result,
    String? error,
    // AgendaRequest? request,
    // bool? agendaParam,
  }) {
    return AgendaInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      // request: request ?? this.request,
      // agendaParam: agendaParam ?? this.agendaParam,
    );
  }
}
