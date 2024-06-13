import 'package:collection/collection.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/features/agendas/data/response/agendas_response.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/meetings_response.dart';

part 'meeting_state.dart';

class MeetingCubit extends MCubit<MeetingInitial> {
  MeetingCubit() : super(MeetingInitial.initial());

  @override
  String get nameCache => 'meeting';

  @override
  String get filter => state.id;

  Future<void> getMeeting({String? id, bool newData = false}) async {
    emit(state.copyWith(id: id));
    if (await checkCashed(newData: newData)) return;

    final pair = await _getDataApi();
    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      await storeData(pair.first!);
      emit(
        state.copyWith(
          statuses: CubitStatuses.done,
          result: pair.first,
        ),
      );
    }
  }

  Future<Pair<Meeting?, String?>> _getDataApi() async {
    final response = await APIService().callApi(type: ApiType.get,
      url: GetUrl.meeting,
      query: {'id': state.id},
    );

    if (response.statusCode.success) {
      return Pair(Meeting.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }

  Future<bool> checkCashed({bool newData = false}) async {
    final cacheType =
        newData ? NeedUpdateEnum.withLoading : await needGetData();

    emit(
      state.copyWith(
        statuses: cacheType.getState,
        result: Meeting.fromJson(await getDataCached()),
      ),
    );

    if (cacheType == NeedUpdateEnum.no) return false;
    return false;
  }

  Future<void> addComment({
    required Comment comment,
    required String agendaId,
  }) async {
    _findAgenda(agendaId, state.result.agendaItems)?.comments.add(comment);
    await storeData(state.result);
  }

  Agenda? _findAgenda(String id, List<Agenda> list) {
    for (var e in list) {
      if (e.id == id) return e;
      return _findAgenda(e.id, e.childrenItems);
    }
    return null;
  }
}
