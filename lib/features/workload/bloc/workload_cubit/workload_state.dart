part of 'workload_cubit.dart';

class WorkloadInitial extends AbstractState<Workload> {
  const WorkloadInitial({
    required super.result,
    super.error,
    super.statuses,
    required this.committeeId,
    required this.tasksPartyId,
    required this.tasks,
    required this.tasksLoading,
    required this.tasksError,
  });

  final String committeeId;

  /// Whose tasks [tasks] holds.
  final String tasksPartyId;
  final List<WorkloadTask> tasks;
  final bool tasksLoading;
  final String tasksError;

  factory WorkloadInitial.initial() {
    return WorkloadInitial(
      result: Workload.empty(),
      error: '',
      statuses: CubitStatuses.init,
      committeeId: '',
      tasksPartyId: '',
      tasks: const [],
      tasksLoading: false,
      tasksError: '',
    );
  }

  @override
  List<Object> get props => [statuses, result, error, committeeId, tasksPartyId, tasks, tasksLoading, tasksError];

  WorkloadInitial copyWith({
    CubitStatuses? statuses,
    Workload? result,
    String? error,
    String? committeeId,
    String? tasksPartyId,
    List<WorkloadTask>? tasks,
    bool? tasksLoading,
    String? tasksError,
  }) {
    return WorkloadInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      committeeId: committeeId ?? this.committeeId,
      tasksPartyId: tasksPartyId ?? this.tasksPartyId,
      tasks: tasks ?? this.tasks,
      tasksLoading: tasksLoading ?? this.tasksLoading,
      tasksError: tasksError ?? this.tasksError,
    );
  }
}
