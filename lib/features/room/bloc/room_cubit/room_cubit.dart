import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:m_cubit/abstraction.dart';
import 'package:mms/core/error/error_manager.dart';
import 'package:mms/core/util/exts.dart';
import 'package:mms/core/util/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/app/app_widget.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../data/request/setting_message.dart';

part 'room_state.dart';

class RoomCubit extends MCubit<RoomInitial> {
  RoomCubit() : super(RoomInitial.initial());

  @override
  get mState => state;

  Future<void> initial() async {
    await state.result.prepareConnection(state.url, state.token);
    state.result.addListener(_sortParticipants);
    setListeners();
  }

  void setListeners() {
    state.listener
      //end call
      ..on<RoomDisconnectedEvent>((e) {
        emit(state.copyWith(id: state.notifyIndex + 1));
        // end call and dispose all
      })
      //re sort list users
      ..on<ParticipantEvent>((e) {
        loggerObject.w(e.toString());
        _sortParticipants();
      })
      ..on<LocalTrackPublishedEvent>((e) => _sortParticipants())
      ..on<LocalTrackUnpublishedEvent>((e) => _sortParticipants())
      ..on<TrackSubscribedEvent>((e) => _sortParticipants())
      ..on<TrackUnsubscribedEvent>((e) => _sortParticipants())
      ..on<ParticipantNameUpdatedEvent>((e) => _sortParticipants())
      ..on<DataReceivedEvent>((e) {
        // Events handler most be hear, not another place.
        // Cuse this is the listener for data event.
        // Data will be as JSON type with modl with MessageAction enum.

        try {
          final message = SettingMessage.fromJson(jsonDecode(utf8.decode(e.data)));
          loggerObject.w(message.toJson());
          // if (message.identity != state.result.localParticipant?.identity) return;
          switch (message.action) {
            case ManagerActions.mic:
              break;
            case ManagerActions.video:
              break;
            case ManagerActions.shareScreen:
              break;
            case ManagerActions.raseHand:
              emit(state.copyWith(raiseHands: state.raiseHands..add(message.identity)));
              Future.delayed(
                Duration(seconds: 5),
                () {
                  emit(state.copyWith(raiseHands: {
                    ...state.raiseHands..remove(message.identity),
                  }, id: state.notifyIndex + 1));
                },
              );
              break;
          }
        } catch (err) {
          loggerObject.i('Failed to decode: $err');
        }
      });
  }

  void _sortParticipants() {
    // List<Participant> userMediaTracks = [];
    List<Participant> screenTracks = [];

    for (var participant in state.result.remoteParticipants.values) {
      if (participant.videoTrackPublications.isNotEmpty) {
        screenTracks.add(participant);
      }
    }

    if (state.result.localParticipant != null) {
      if ((state.result.localParticipant?.videoTrackPublications ?? []).isNotEmpty) {
        screenTracks.add(state.result.localParticipant!);
      }
    }
    //
    // userMediaTracks.sort((a, b) {
    //   if (a.isSpeaking && b.isSpeaking) {
    //     return (a.audioLevel > b.audioLevel) ? -1 : 1;
    //   }
    //
    //   // last spoken at
    //   final aSpokeAt = a.lastSpokeAt?.millisecondsSinceEpoch ?? 0;
    //   final bSpokeAt = b.lastSpokeAt?.millisecondsSinceEpoch ?? 0;
    //
    //   if (aSpokeAt != bSpokeAt) return aSpokeAt > bSpokeAt ? -1 : 1;
    //
    //   // video on
    //   if (a.hasVideo != b.hasVideo) return a.hasVideo ? -1 : 1;
    //
    //   // joinedAt
    //   return a.joinedAt.millisecondsSinceEpoch - b.joinedAt.millisecondsSinceEpoch;
    // });

    final list = [
      ...screenTracks, /*...userMediaTracks*/
    ];

    final selectedTruck = state.selectedParticipantId.isNotEmpty
        ? null
        : list.isEmpty
            ? null
            : list.first.identity;

    emit(state.copyWith(participantTracks: list, selectedParticipantId: selectedTruck, id: state.notifyIndex + 1));
  }

  Future<void> connect() async {
    try {
      emit(state.copyWith(statuses: CubitStatuses.loading));
      await state.result.connect(
        state.url,
        state.token,
        fastConnectOptions: FastConnectOptions(),
      );
      state.result.connectionState;
      emit(state.copyWith(statuses: CubitStatuses.done));
    } catch (e) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: e.toString()));
      showErrorFromApi(state);
    }
  }

  void disconnect() async {
    final result = await ctx!.showDisconnectDialog();
    try {
      if (result == true) await state.result.disconnect();
    } catch (e) {
      loggerObject.e(e);
    }
  }

  void setUrl(String url) => emit(state.copyWith(url: url));

  void setToken(String token) {
    AppSharedPreference.cashToken(token);
    emit(
      state.copyWith(token: token),
    );
  }

  void selectParticipant(String participantId) {
    emit(state.copyWith(selectedParticipantId: participantId));
  }

  Future<bool> _checkPermissions() async {
    var cameraStatus = await Permission.camera.request();
    var micStatus = await Permission.microphone.request();

    return cameraStatus.isGranted && micStatus.isGranted;
  }

  @override
  Future<void> close() {
    (() async {
      state.result.removeListener(_sortParticipants);
      await state.listener.dispose();
      await state.result.dispose();
    })();
    return super.close();
  }
}
