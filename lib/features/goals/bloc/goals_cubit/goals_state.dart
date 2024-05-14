part of 'goals_cubit.dart';

class GoalInitial extends AbstractCubit<List<Goal>> {
  // final GoalRequest request;
  // final  bool goalParam;
  const GoalInitial({
    required super.result,
    super.error,
    // required this.request,
    // required this.goalParam,
    super.statuses,
  });//

  factory GoalInitial.initial() {
    return const GoalInitial(
      result: [],
      error: '',
      // goalParam: false,
      // request: GoalRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  GoalInitial copyWith({
    CubitStatuses? statuses,
    List<Goal>? result,
    String? error,
    // GoalRequest? request,
    // bool? goalParam,
  }) {
    return GoalInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      // request: request ?? this.request,
      // goalParam: goalParam ?? this.goalParam,
    );
  }
}
