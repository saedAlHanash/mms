part of 'annual_report_cubit.dart';

class AnnualReportInitial extends AbstractState<AnnualReport> {
  const AnnualReportInitial({
    required super.result,
    super.error,
    super.statuses,
    required this.committeeId,
    required this.year,
  });

  final String committeeId;
  final int year;

  factory AnnualReportInitial.initial() {
    return AnnualReportInitial(
      result: AnnualReport.empty,
      error: '',
      statuses: CubitStatuses.init,
      committeeId: '',
      year: DateTime.now().year,
    );
  }

  @override
  List<Object> get props => [statuses, identityHashCode(result), error, committeeId, year];

  AnnualReportInitial copyWith({
    CubitStatuses? statuses,
    AnnualReport? result,
    String? error,
    String? committeeId,
    int? year,
  }) {
    return AnnualReportInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      committeeId: committeeId ?? this.committeeId,
      year: year ?? this.year,
    );
  }
}
