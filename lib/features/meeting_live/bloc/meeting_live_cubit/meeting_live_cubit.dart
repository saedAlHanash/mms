import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/error/error_manager.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/core/util/pair_class.dart';
import 'package:mms/features/meeting_live/data/request/floor_request.dart';
import 'package:mms/features/meeting_live/data/response/meeting_live_response.dart';

part 'meeting_live_state.dart';

/// Live state of a running meeting (`MeetingLive`): the item on screen with its
/// timer, the speaker queue and the quorum.
///
/// - Refetched on every SignalR `LiveStateUpdated` (debounced: timers send often).
/// - Also polled every 20 s, like the web, in case the hub connection drops.
/// - Clocks tick locally between refreshes (see `fetchedAt`).
class MeetingLiveCubit extends Cubit<MeetingLiveInitial> {
  MeetingLiveCubit() : super(MeetingLiveInitial.initial());

  static const _pollEvery = Duration(seconds: 20);
  static const _debounce = Duration(milliseconds: 300);

  Timer? _poll;
  Timer? _debounceTimer;

  //region getData
  /// Starts following [meetingId] (the meeting is running). Idempotent.
  Future<void> start(String meetingId) async {
    if (meetingId.isEmpty) return;
    if (_poll != null && state.meetingId == meetingId) return;
    emit(state.copyWith(meetingId: meetingId, statuses: CubitStatuses.loading));
    _poll?.cancel();
    _poll = Timer.periodic(_pollEvery, (_) => getData());
    await getData();
  }

  /// Stops following (the meeting is no longer running, or the page closed).
  void stop() {
    _poll?.cancel();
    _poll = null;
    _debounceTimer?.cancel();
    _debounceTimer = null;
  }

  /// SignalR `LiveStateUpdated`: refetch once the burst settles.
  void onLiveUpdated() {
    if (_poll == null) return;
    _debounceTimer?.cancel();
    _debounceTimer = Timer(_debounce, getData);
  }

  Future<void> getData() async {
    if (state.meetingId.isEmpty) return;
    final pair = await _getDataApi();
    if (isClosed) return;

    if (pair.first == null) {
      // Quiet: the panel keeps the last state and the next refresh retries.
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      _emitState(pair.first!);
    }
  }

  Future<Pair<MeetingLiveState?, String?>> _getDataApi() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.liveState,
      query: {'meetingId': state.meetingId},
    );

    if (response.statusCode.success) {
      return Pair(MeetingLiveState.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }
  //endregion

  //region CRUD
  /// Asks for the floor (or raises a point of order, which goes first).
  Future<void> requestFloor({required bool pointOfOrder}) => _send(
        PostUrl.requestFloor,
        RequestFloorRequest(meetingId: state.meetingId, pointOfOrder: pointOfOrder).toJson(),
      );

  /// Withdraws my waiting request.
  Future<void> withdrawFloor() async {
    final id = state.result.myRequest?.id;
    if (id == null) return;
    await _send(PostUrl.withdrawFloor, SpeakerIdRequest(id: id).toJson());
  }

  // Chair / secretary controls (`canControl`).

  /// Puts [agendaItemId] on screen, or clears it with null.
  Future<void> setCurrentItem(String? agendaItemId) => _send(
        PostUrl.liveSetCurrentItem,
        SetCurrentItemRequest(meetingId: state.meetingId, agendaItemId: agendaItemId).toJson(),
      );

  /// Timer of the item on screen. Start also pauses any other running item.
  Future<void> setTimer(LiveTimerAction action, {int seconds = 0}) async {
    final id = state.result.currentItem?.id;
    if (id == null) return;
    await _send(
      PostUrl.liveSetTimer,
      SetTimerRequest(agendaItemId: id, action: action, seconds: seconds).toJson(),
    );
  }

  /// Ends the current speaker and gives the floor to the first waiting.
  Future<void> nextSpeaker() =>
      _send(PostUrl.liveNextSpeaker, MeetingIdRequest(meetingId: state.meetingId).toJson());

  Future<void> endSpeaker() =>
      _send(PostUrl.liveEndSpeaker, MeetingIdRequest(meetingId: state.meetingId).toJson());

  /// Out of turn.
  Future<void> giveFloor(String requestId) =>
      _send(PostUrl.liveGiveFloor, SpeakerIdRequest(id: requestId).toJson());

  Future<void> skipSpeaker(String requestId) =>
      _send(PostUrl.liveSkipSpeaker, SpeakerIdRequest(id: requestId).toJson());

  /// Withdraws someone's waiting request on their behalf (the lead may).
  Future<void> withdrawFor(String requestId) =>
      _send(PostUrl.withdrawFloor, SpeakerIdRequest(id: requestId).toJson());

  /// 0 means no limit.
  Future<void> setSpeakerLimit(int seconds) => _send(
        PostUrl.liveSetSpeakerLimit,
        SetSpeakerLimitRequest(meetingId: state.meetingId, seconds: seconds.clamp(0, 3600)).toJson(),
      );

  Future<void> _send(String url, Map<String, dynamic> body) async {
    if (state.sending) return;
    emit(state.copyWith(sending: true));

    final response = await APIService().callApi(type: ApiType.post, url: url, body: body);
    if (isClosed) return;

    if (response.statusCode.success) {
      emit(state.copyWith(sending: false));
      _emitState(MeetingLiveState.fromJson(response.jsonBody));
    } else {
      emit(state.copyWith(sending: false, statuses: CubitStatuses.error, error: response.getPairError.second));
      showErrorFromApi(state);
    }
  }
  //endregion

  //region UI Methods
  void _emitState(MeetingLiveState live) {
    emit(state.copyWith(statuses: CubitStatuses.done, result: live, fetchedAt: DateTime.now()));
  }
  //endregion

  @override
  Future<void> close() {
    stop();
    return super.close();
  }
}
