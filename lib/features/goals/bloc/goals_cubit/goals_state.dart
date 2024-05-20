part of 'goals_cubit.dart';

class GoaslInitial extends AbstractCubit<List<Goal>> {
  // final GoalRequest request;
  // final  bool goalParam;
  const GoaslInitial({
    required super.result,
    super.error,
    // required this.request,
    // required this.goalParam,
    super.statuses,
  });//

  factory GoaslInitial.initial() {
    return const GoaslInitial(
      result: [],
      error: '',
      // goalParam: false,
      // request: GoalRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  GoaslInitial copyWith({
    CubitStatuses? statuses,
    List<Goal>? result,
    String? error,
    // GoalRequest? request,
    // bool? goalParam,
  }) {
    return GoaslInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      // request: request ?? this.request,
      // goalParam: goalParam ?? this.goalParam,
    );
  }
}
