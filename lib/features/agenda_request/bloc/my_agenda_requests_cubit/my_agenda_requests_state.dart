part of 'my_agenda_requests_cubit.dart';

class MyAgendaRequestsInitial extends AbstractState<List<AgendaItemRequest>> {
  const MyAgendaRequestsInitial({
    required super.result,
    super.error,
    super.statuses,
    required this.meetingId,
    required this.sending,
    required this.deletingId,
  });

  final String meetingId;

  /// A new proposal is being uploaded / sent.
  final bool sending;

  /// The proposal being withdrawn, for its loading state.
  final String deletingId;

  factory MyAgendaRequestsInitial.initial() {
    return const MyAgendaRequestsInitial(
      result: [],
      error: '',
      statuses: CubitStatuses.init,
      meetingId: '',
      sending: false,
      deletingId: '',
    );
  }

  @override
  List<Object> get props => [statuses, result, error, meetingId, sending, deletingId];

  MyAgendaRequestsInitial copyWith({
    CubitStatuses? statuses,
    List<AgendaItemRequest>? result,
    String? error,
    String? meetingId,
    bool? sending,
    String? deletingId,
  }) {
    return MyAgendaRequestsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      meetingId: meetingId ?? this.meetingId,
      sending: sending ?? this.sending,
      deletingId: deletingId ?? this.deletingId,
    );
  }
}
