part of 'absence_review_cubit.dart';

class AbsenceReviewInitial extends AbstractState<bool> {
  const AbsenceReviewInitial({
    required super.result,
    super.error,
    super.statuses,
    required this.busyId,
    required this.answered,
  });

  /// The request being answered, or ''.
  final String busyId;

  /// Answers given here, until the meeting is fetched again.
  final Map<String, AbsenceStatus> answered;

  factory AbsenceReviewInitial.initial() {
    return const AbsenceReviewInitial(
      result: false,
      error: '',
      statuses: CubitStatuses.init,
      busyId: '',
      answered: {},
    );
  }

  @override
  List<Object> get props => [statuses, result, error, busyId, answered];

  AbsenceReviewInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    String? busyId,
    Map<String, AbsenceStatus>? answered,
  }) {
    return AbsenceReviewInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      busyId: busyId ?? this.busyId,
      answered: answered ?? this.answered,
    );
  }
}
