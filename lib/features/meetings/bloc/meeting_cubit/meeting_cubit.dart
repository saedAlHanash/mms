import 'package:animated_tree_view/node/node.dart';
import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:collection/collection.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/features/agendas/data/response/agendas_response.dart';
import 'package:mms/features/meeting_hub/data/response/hub_message_response.dart';
import 'package:mms/features/poll/data/response/poll_response.dart';

import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/core/util/pair_class.dart';
import 'package:mms/features/meetings/data/response/meetings_response.dart';

part 'meeting_state.dart';

class MeetingCubit extends MCubit<MeetingInitial> {
  MeetingCubit() : super(MeetingInitial.initial());
  @override
  get mState => state;
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

  //region Live updates (SignalR)

  /// Applies one meeting hub message to the open meeting.
  /// Idempotent: objects are upserted by `id`, so repeated or late
  /// messages after a reconnect don't duplicate anything.
  Future<void> applyHubMessage(HubMessage message) async {
    final meeting = state.result;
    if (meeting.id.isEmpty) return;

    // Messages for another meeting are ignored (poll results carry no meetingId).
    if (message.meetingId.isNotEmpty && message.meetingId != meeting.id) return;

    final data = message.data;
    final Meeting updated;

    switch (message.event) {
      case null:
        return;
      case .liveStateUpdated:
        // For the live screen (MeetingLive/GetState), which the app doesn't show yet.
        return;
      case .agendaItemStatusUpdated:
        // The payload's nested lists are incomplete: reload the meeting (agenda included).
        await getData(newData: true);
        return;
      case .pollStatusUpdated:
        updated = meeting.copyWith(polls: _upsert(meeting.polls, Poll.fromJson(data), (e) => e.id));
      case .pollPublished:
        final result = PollResult.fromJson(data);
        updated = meeting.copyWith(
          pollResults: _upsert(meeting.pollResults, result, (e) => e.id),
          // The poll is now shown through its published result.
          polls: meeting.polls.where((e) => e.id != result.id).toList(),
        );
      case .decisionPublished:
        updated = meeting.copyWith(decisions: _upsert(meeting.decisions, Decision.fromJson(data), (e) => e.id));
      case .discussionStatusUpdated:
        updated = meeting.copyWith(
          discussions: _upsert(meeting.discussions, Discussion.fromJson(data), (e) => e.id),
        );
    }

    emit(state.copyWith(result: updated));
    await saveData(updated);
  }

  /// Replaces the item with the same id, or appends it.
  List<T> _upsert<T>(List<T> list, T item, String Function(T e) idOf) {
    final id = idOf(item);
    final copy = List<T>.of(list);
    final index = copy.indexWhere((e) => idOf(e) == id);
    if (index == -1) {
      copy.add(item);
    } else {
      copy[index] = item;
    }
    return copy;
  }

  //endregion
}
