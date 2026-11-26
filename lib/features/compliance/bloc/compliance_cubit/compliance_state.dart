part of 'compliance_cubit.dart';

class ComplianceInitial extends AbstractState<ComplianceStatus> {
  const ComplianceInitial({
    required super.result,
    super.error,
    super.statuses,
    required this.committeeId,
    required this.year,
  });

  final String committeeId;
  final int year;

  factory ComplianceInitial.initial() {
    return ComplianceInitial(
      result: ComplianceStatus.empty,
      error: '',
      statuses: CubitStatuses.init,
      committeeId: '',
      year: DateTime.now().year,
    );
  }

  @override
  List<Object> get props => [statuses, identityHashCode(result), error, committeeId, year];

  ComplianceInitial copyWith({
    CubitStatuses? statuses,
    ComplianceStatus? result,
    String? error,
    String? committeeId,
    int? year,
  }) {
    return ComplianceInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      committeeId: committeeId ?? this.committeeId,
      year: year ?? this.year,
    );
  }
}
