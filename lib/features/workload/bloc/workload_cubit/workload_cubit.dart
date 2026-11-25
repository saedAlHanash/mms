import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/features/workload/data/response/workload_response.dart';

part 'workload_state.dart';

/// A committee's workload (`Workload/Get`), and one member's tasks (`Workload/GetTasks`).
class WorkloadCubit extends Cubit<WorkloadInitial> {
  WorkloadCubit() : super(WorkloadInitial.initial());

  //region getData
  Future<void> getData({String? committeeId}) async {
    final id = committeeId ?? state.committeeId;
    if (id.isEmpty) return;
    emit(state.copyWith(statuses: CubitStatuses.loading, committeeId: id));

    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.workload,
      query: {'committeeId': id},
    );
    if (isClosed) return;

    if (response.statusCode.success) {
      emit(state.copyWith(statuses: CubitStatuses.done, result: Workload.fromJson(response.jsonBody)));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.error, error: response.getPairError.second));
    }
  }

  /// Loads [partyId]'s tasks into [WorkloadInitial.tasks].
  Future<void> getTasks(String partyId) async {
    emit(state.copyWith(tasksPartyId: partyId, tasks: const [], tasksLoading: true, tasksError: ''));

    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.workloadTasks,
      query: {'committeeId': state.committeeId, 'partyId': partyId},
    );
    if (isClosed || state.tasksPartyId != partyId) return;

    if (response.statusCode.success) {
      final list = response.jsonBody['data'] is List ? response.jsonBody['data'] as List : const [];
      final tasks = list.whereType<Map<String, dynamic>>().map(WorkloadTask.fromJson).toList()
        // Overdue, then by due date.
        ..sort((a, b) {
          if (a.overdue != b.overdue) return a.overdue ? -1 : 1;
          return (a.dueDate ?? DateTime(9999)).compareTo(b.dueDate ?? DateTime(9999));
        });
      emit(state.copyWith(tasks: tasks, tasksLoading: false));
    } else {
      emit(state.copyWith(tasksLoading: false, tasksError: response.getPairError.second));
    }
  }
  //endregion
}
