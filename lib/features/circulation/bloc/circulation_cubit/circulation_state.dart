part of 'circulation_cubit.dart';

class CirculationInitial extends AbstractState<Circulation> {
  const CirculationInitial({
    required super.result,
    super.error,
    super.statuses,
    required this.circulationId,
    required this.voting,
    required this.openingFile,
  });

  final String circulationId;

  /// The choice being sent, for its button's loading state.
  final CirculationChoice? voting;
  final bool openingFile;

  factory CirculationInitial.initial() {
    return CirculationInitial(
      result: Circulation.empty(),
      error: '',
      statuses: CubitStatuses.init,
      circulationId: '',
      voting: null,
      openingFile: false,
    );
  }

  @override
  List<Object> get props => [statuses, result, error, circulationId, voting?.index ?? -1, openingFile];

  CirculationInitial copyWith({
    CubitStatuses? statuses,
    Circulation? result,
    String? error,
    String? circulationId,
    CirculationChoice? Function()? voting,
    bool? openingFile,
  }) {
    return CirculationInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      circulationId: circulationId ?? this.circulationId,
      voting: voting != null ? voting() : this.voting,
      openingFile: openingFile ?? this.openingFile,
    );
  }
}
