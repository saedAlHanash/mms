import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/error/error_manager.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/features/agenda_request/data/response/agenda_request_response.dart';

part 'review_agenda_requests_state.dart';

/// Everyone's proposals for a meeting, for the secretary (`GetByMeeting` returns
/// them all to the secretary), with accepting (linked to an agenda item) and rejecting.
class ReviewAgendaRequestsCubit extends Cubit<ReviewAgendaRequestsInitial> {
  ReviewAgendaRequestsCubit() : super(ReviewAgendaRequestsInitial.initial());

  //region getData
  Future<void> getData({String? meetingId}) async {
    final id = meetingId ?? state.meetingId;
    if (id.isEmpty) return;
    emit(state.copyWith(statuses: CubitStatuses.loading, meetingId: id));

    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.agendaRequestsByMeeting,
      query: {'meetingId': id},
    );
    if (isClosed) return;

    if (response.statusCode.success) {
      final list = response.jsonBody['data'] is List ? response.jsonBody['data'] as List : const [];
      final items = list.whereType<Map<String, dynamic>>().map(AgendaItemRequest.fromJson).toList();
      emit(state.copyWith(statuses: CubitStatuses.done, result: _sorted(items)));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.error, error: response.getPairError.second));
    }
  }
  //endregion

  //region CRUD
  /// Links the proposal to an agenda item of the same meeting (created on the web).
  Future<bool> accept(String id, {required String agendaItemId}) =>
      _review(id, PutUrl.acceptAgendaRequest, {'id': id, 'agendaItemId': agendaItemId}, AgendaRequestStatus.accepted);

  Future<bool> reject(String id, {required String reason}) =>
      _review(id, PutUrl.rejectAgendaRequest, {'id': id, 'reason': reason}, AgendaRequestStatus.rejected);

  Future<bool> _review(String id, String url, Map<String, dynamic> body, AgendaRequestStatus status) async {
    if (state.busyId.isNotEmpty) return false;
    emit(state.copyWith(busyId: id));

    final response = await APIService().callApi(type: ApiType.put, url: url, body: body);
    if (isClosed) return false;

    if (response.statusCode.success) {
      // The server answers with an empty 200: refetch for the final state.
      emit(state.copyWith(busyId: ''));
      await getData();
      return true;
    }

    emit(state.copyWith(busyId: '', statuses: CubitStatuses.error, error: response.getPairError.second));
    showErrorFromApi(state);
    return false;
  }
  //endregion

  /// Pending first, then newest.
  static List<AgendaItemRequest> _sorted(List<AgendaItemRequest> items) => items.sorted((a, b) {
    final pa = a.status == AgendaRequestStatus.pending ? 0 : 1;
    final pb = b.status == AgendaRequestStatus.pending ? 0 : 1;
    if (pa != pb) return pa.compareTo(pb);
    return (b.created ?? DateTime(0)).compareTo(a.created ?? DateTime(0));
  });
}
