import 'package:animated_tree_view/node/node.dart';
import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:collection/collection.dart';
import 'package:m_cubit/abstraction.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/features/agendas/data/response/agendas_response.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/meetings_response.dart';

part 'meeting_state.dart';

class MeetingCubit extends MCubit<MeetingInitial> {
  MeetingCubit() : super(MeetingInitial.initial());

  @override
  String get nameCache => 'meeting';

  @override
  String get filter => state.request ?? '';

  Future<void> getData({String? id, bool newData = false}) async {
    emit(state.copyWith(request: id));
    getDataAbstract(
      fromJson: Meeting.fromJson,
      state: state,
      newData: newData,
      getDataApi: _getData,
    );
  }

  Future<Pair<Meeting?, String?>> _getData() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.meeting,
      query: {'id': state.request},
    );

    if (response.statusCode.success) {
      return Pair(Meeting.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }

  Future<void> addComment({
    required Comment comment,
    required String agendaId,
  }) async {
    _findAgenda(agendaId, state.result.agendaItems)?.comments.add(comment);
    await saveData(state.result);
  }

  Agenda? _findAgenda(String id, List<Agenda> list) {
    for (var e in list) {
      if (e.id == id) return e;
      return _findAgenda(e.id, e.childrenItems);
    }
    return null;
  }

  Future<void> addDiscussionComment({
    required DiscussionComment comment,
    required String discussionId,
  }) async {
    state.result.discussions.firstWhereOrNull((e) => e.id == discussionId)?.comments.add(comment);
    await saveData(state.result);
  }
}
