part of 'delegations_cubit.dart';

class DelegationsInitial extends AbstractState<List<Delegation>> {
  const DelegationsInitial({
    required super.result,
    super.error,
    super.statuses,
    required this.committeeId,
    required this.sending,
    required this.revokingId,
  });

  final String committeeId;

  /// An add is on its way.
  final bool sending;

  /// The delegation being revoked, or ''.
  final String revokingId;

  /// The role I hold through a delegation right now (the banner).
  Delegation? get actingAs => result.firstWhereOrNull((e) => e.isToMe && e.state == DelegationState.active);

  factory DelegationsInitial.initial() {
    return const DelegationsInitial(
      result: [],
      error: '',
      statuses: CubitStatuses.init,
      committeeId: '',
      sending: false,
      revokingId: '',
    );
  }

  @override
  List<Object> get props => [statuses, result, error, committeeId, sending, revokingId];

  DelegationsInitial copyWith({
    CubitStatuses? statuses,
    List<Delegation>? result,
    String? error,
    String? committeeId,
    bool? sending,
    String? revokingId,
  }) {
    return DelegationsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      committeeId: committeeId ?? this.committeeId,
      sending: sending ?? this.sending,
      revokingId: revokingId ?? this.revokingId,
    );
  }
}
