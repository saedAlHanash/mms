import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/error/error_manager.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/helper/launcher_helper.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/core/util/pair_class.dart';
import 'package:mms/features/circulation/data/request/circulation_requests.dart';
import 'package:mms/features/circulation/data/response/circulation_response.dart';
import 'package:mms/features/files/data/response/file_response.dart';

part 'circulation_state.dart';

/// One circulation with its votes (`Circulation/Get`), voting (`Circulation/Vote`)
/// and opening its attachment.
class CirculationCubit extends Cubit<CirculationInitial> {
  CirculationCubit() : super(CirculationInitial.initial());

  //region getData
  Future<void> getData({String? id}) async {
    final circulationId = id ?? state.circulationId;
    if (circulationId.isEmpty) return;
    emit(state.copyWith(statuses: CubitStatuses.loading, circulationId: circulationId));

    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.circulation,
      query: {'id': circulationId},
    );
    if (isClosed) return;

    if (response.statusCode.success) {
      emit(state.copyWith(statuses: CubitStatuses.done, result: Circulation.fromJson(response.jsonBody)));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.error, error: response.getPairError.second));
    }
  }
  //endregion

  //region CRUD
  /// Casts (or changes) my vote; returns the updated circulation, or null.
  Future<Circulation?> vote(CirculationChoice choice, {String reason = ''}) async {
    if (state.voting != null) return null;
    emit(state.copyWith(voting: () => choice));

    final response = await APIService().callApi(
      type: ApiType.post,
      url: PostUrl.circulationVote,
      body: CastCirculationVote(circulationId: state.circulationId, choice: choice, reason: reason).toJson(),
    );
    if (isClosed) return null;

    if (response.statusCode.success) {
      final updated = Circulation.fromJson(response.jsonBody);
      if (updated.isEmpty) {
        emit(state.copyWith(voting: () => null));
        await getData();
        return state.result;
      }
      emit(state.copyWith(voting: () => null, result: updated));
      return updated;
    }

    emit(state.copyWith(voting: () => null, statuses: CubitStatuses.error, error: response.getPairError.second));
    showErrorFromApi(state);
    // Keep the screen in step (e.g. the deadline passed meanwhile).
    getData();
    return null;
  }

  /// The DTO has only `mediaId`: resolve its link through `FileManager/Get`.
  Future<void> openAttachment() async {
    final item = state.result;
    if (!item.hasAttachment || state.openingFile) return;

    if (item.mediaSavedPath.isNotEmpty) {
      await LauncherHelper.openPage(item.mediaSavedPath);
      return;
    }

    emit(state.copyWith(openingFile: true));
    final pair = await _getFile(item.mediaId);
    if (isClosed) return;
    emit(state.copyWith(openingFile: false));

    final path = pair.first?.savedPath ?? '';
    if (path.isEmpty) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second ?? ''));
      showErrorFromApi(state);
      return;
    }
    await LauncherHelper.openPage(path);
  }

  Future<Pair<FileResponse?, String?>> _getFile(String id) async {
    final response = await APIService().callApi(type: ApiType.get, url: GetUrl.fileById, query: {'id': id});
    if (response.statusCode.success) {
      final json = response.jsonBody;
      final map = json['data'] is Map<String, dynamic> ? json['data'] as Map<String, dynamic> : json;
      return Pair(FileResponse.fromJson(map), null);
    }
    return response.getPairError;
  }
  //endregion
}
