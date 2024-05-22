part of 'agendas_cubit.dart';

class GoaslInitial extends AbstractCubit<List<Agenda>> {
  // final AgendaRequest request;
  // final  bool agendaParam;
  const GoaslInitial({
    required super.result,
    super.error,
    // required this.request,
    // required this.agendaParam,
    super.statuses,
  });//

  factory GoaslInitial.initial() {
    return const GoaslInitial(
      result: [],
      error: '',
      // agendaParam: false,
      // request: AgendaRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  GoaslInitial copyWith({
    CubitStatuses? statuses,
    List<Agenda>? result,
    String? error,
    // AgendaRequest? request,
    // bool? agendaParam,
  }) {
    return GoaslInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      // request: request ?? this.request,
      // agendaParam: agendaParam ?? this.agendaParam,
    );
  }
}
