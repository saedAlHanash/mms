import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/error/error_manager.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/core/util/pair_class.dart';
import 'package:mms/features/agenda_request/data/request/create_agenda_request.dart';
import 'package:mms/features/agenda_request/data/response/agenda_request_response.dart';
import 'package:mms/features/files/data/response/file_response.dart';

part 'my_agenda_requests_state.dart';

/// My agenda item proposals for a meeting (`AgendaItemRequest/GetByMeeting`
/// returns only one's own for a member), proposing one and withdrawing it.
class MyAgendaRequestsCubit extends Cubit<MyAgendaRequestsInitial> {
  MyAgendaRequestsCubit() : super(MyAgendaRequestsInitial.initial());

  //region getData
  Future<void> getData({String? meetingId}) async {
    final id = meetingId ?? state.meetingId;
    if (id.isEmpty) return;
    emit(state.copyWith(statuses: CubitStatuses.loading, meetingId: id));

    final pair = await _getDataApi(id);
    if (isClosed) return;

    if (pair.first == null) {
      // Older backends don't have it: the section just stays empty.
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<AgendaItemRequest>?, String?>> _getDataApi(String meetingId) async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.agendaRequestsByMeeting,
      query: {'meetingId': meetingId},
    );

    if (response.statusCode.success) {
      final list = (response.jsonBody['data'] as List? ?? []);
      final myId = AppProvider.getParty.id;
      final items =
          list
              .map((e) => AgendaItemRequest.fromJson(e))
              // A secretary gets everyone's; this list is "mine".
              .where((e) => e.partyId.isEmpty || e.partyId == myId)
              .toList()
            ..sort((a, b) => (b.created ?? DateTime(0)).compareTo(a.created ?? DateTime(0)));
      return Pair(items, null);
    } else {
      return response.getPairError;
    }
  }
  //endregion

  //region CRUD
  /// Uploads the attachment (if any), then sends the proposal.
  /// Returns true when it was recorded.
  Future<bool> add(CreateAgendaRequest request) async {
    if (state.sending) return false;
    emit(state.copyWith(sending: true));

    String? mediaId;
    if (request.attachment case final file?) {
      final upload = await APIService().uploadMultiPart(
        url: PostUrl.uploadFile,
        files: [UploadFile(fileBytes: file.bytes, fileName: file.name)],
      );
      if (isClosed) return false;
      if (!upload.statusCode.success) return _failed(upload.getPairError.second);
      mediaId = FileResponse.fromJson(upload.jsonBodyPure).id;
    }

    final response = await APIService().callApi(
      type: ApiType.post,
      url: PostUrl.addAgendaRequest,
      body: request.toJson(mediaId: mediaId),
    );
    if (isClosed) return false;

    if (!response.statusCode.success) return _failed(response.getPairError.second);

    final added = AgendaItemRequest.fromJson(response.jsonBody);
    emit(state.copyWith(sending: false, result: [added, ...state.result]));
    // The server answers with the record; refetch if it didn't.
    if (added.id.isEmpty) getData();
    return true;
  }

  /// Withdraws a pending proposal; returns true when removed.
  Future<bool> delete(String id) async {
    if (state.deletingId.isNotEmpty) return false;
    emit(state.copyWith(deletingId: id));

    final response = await APIService().callApi(
      type: ApiType.delete,
      url: DeleteUrl.agendaRequest,
      query: {'id': id},
    );
    if (isClosed) return false;

    if (response.statusCode.success) {
      emit(state.copyWith(deletingId: '', result: state.result.where((e) => e.id != id).toList()));
      return true;
    }

    emit(state.copyWith(deletingId: '', statuses: CubitStatuses.error, error: response.getPairError.second));
    showErrorFromApi(state);
    return false;
  }

  bool _failed(String? error) {
    emit(state.copyWith(sending: false, statuses: CubitStatuses.error, error: error));
    showErrorFromApi(state);
    return false;
  }
  //endregion
}
