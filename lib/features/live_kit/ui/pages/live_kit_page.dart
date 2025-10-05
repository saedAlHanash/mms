import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter_background/flutter_background.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:mms/core/util/exts.dart';
import 'package:mms/core/util/my_style.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/features/live_kit/ui/widget/controls.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/snack_bar_message.dart';
import '../../data/response/setting_message.dart';
import '../widget/participant_info.dart';
import '../widget/users/dynamic_user.dart';
import 'package:permission_handler/permission_handler.dart';

class LiveKitPage extends StatefulWidget {
  const LiveKitPage({super.key, required this.isOpen, required this.link, required this.token});

  final bool isOpen;
  final String link;
  final String token;

  @override
  State<LiveKitPage> createState() => _LiveKitPageState();
}

class _LiveKitPageState extends State<LiveKitPage> {
  bool _busy = false;
  bool _connected = false;
  Room? room;
  EventsListener<RoomEvent>? listener;
  List<ParticipantTrack> participantTracks = [];

  void showFullScreenDialog() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      pageBuilder: (context, _, __) {
        final item = participantTracks.isNotEmpty
            ? participantTracks.first
            : ParticipantTrack(
                participant: room!.localParticipant!,
                type: MediaType.media,
              );
        return _Temp(item: item);
      },
    );
  }

  Future<void> _checkPermissions() async {
    // var status = await Permission.bluetooth.request();
    // if (status.isPermanentlyDenied) {
    //   print('Bluetooth Permission disabled');
    // }
    //
    // status = await Permission.bluetoothConnect.request();
    // if (status.isPermanentlyDenied) {
    //   print('Bluetooth Connect Permission disabled');
    // }

    await Permission.camera.request();

    await Permission.microphone.request();
  }

  @override
  void initState() {
    _checkPermissions();
    super.initState();
  }

  @override
  void dispose() {
    (() async {
      try {
        room?.removeListener(_sortParticipants);
        await listener?.dispose();
        await room?.dispose();
      } catch (e) {
        loggerObject.e(e);
      }
    })();

    super.dispose();
  }

  /// for more information, see [event types](https://docs.livekit.io/client/events/#events)
  void _setUpListeners() => listener
    ?..on<RoomDisconnectedEvent>((event) async {
      WidgetsBindingCompatible.instance
          ?.addPostFrameCallback((timeStamp) => Navigator.popUntil(context, (route) => route.isFirst));
    })
    ..on<ParticipantEvent>((event) {
      // sort participants on many track events as noted in documentation linked above
      _sortParticipants();
    })
    ..on<RoomRecordingStatusChanged>((event) {
      context.showRecordingStatusChangedDialog(event.activeRecording);
    })
    ..on<LocalTrackPublishedEvent>((_) => _sortParticipants())
    ..on<LocalTrackUnpublishedEvent>((_) => _sortParticipants())
    ..on<TrackSubscribedEvent>((_) => _sortParticipants())
    ..on<TrackUnsubscribedEvent>((_) => _sortParticipants())
    ..on<ParticipantNameUpdatedEvent>((event) {
      _sortParticipants();
    })
    ..on<DataReceivedEvent>((event) {
      try {
        final me = room?.localParticipant;
        if (me == null) return;
        final message = SettingMessage.fromJson(jsonDecode(utf8.decode(event.data)));
        print(message.toJson());
        if (message.sid != me.sid) return;
        setState(() {
          switch (message.action) {
            case ManagerActions.mic:
              me.setMicrophoneEnabled(me.isMuted);

              break;
            case ManagerActions.video:
              print('me.isCameraEnabled():${me.isCameraEnabled()}');
              me.setCameraEnabled(!(me.isCameraEnabled()));

              break;
            case ManagerActions.shareScreen:
              me.setScreenShareEnabled(!(me.isScreenShareEnabled()));
              break;
            case ManagerActions.raseHand:
              break;
          }
        });
        if (message.action == ManagerActions.mic) {}
      } catch (err) {
        print('Failed to decode: $err');
      }
    })
    ..on<AudioPlaybackStatusChanged>((event) async {
      if (!(room?.canPlaybackAudio ?? false)) {
        final yesno = await context.showPlayAudioManuallyDialog();
        if (yesno == true) {
          await room?.startAudio();
        }
      }
    });

  void _enableScreenShare() async {
    if (lkPlatformIs(PlatformType.android)) {
      // Android specific
      bool hasCapturePermission = await Helper.requestCapturePermission();
      if (!hasCapturePermission) {
        return;
      }

      requestBackgroundPermission([bool isRetry = false]) async {
        // Required for android screenshare.
        try {
          bool hasPermissions = await FlutterBackground.hasPermissions;
          if (!isRetry) {
            const androidConfig = FlutterBackgroundAndroidConfig(
              notificationTitle: 'Screen Sharing',
              notificationText: 'LiveKit Example is sharing the screen.',
              notificationImportance: AndroidNotificationImportance.normal,
              notificationIcon: AndroidResource(name: 'livekit_ic_launcher', defType: 'mipmap'),
            );
            hasPermissions = await FlutterBackground.initialize(androidConfig: androidConfig);
          }
          if (hasPermissions && !FlutterBackground.isBackgroundExecutionEnabled) {
            await FlutterBackground.enableBackgroundExecution();
          }
        } catch (e) {
          if (!isRetry) {
            return await Future<void>.delayed(const Duration(seconds: 1), () => requestBackgroundPermission(true));
          }
          print('could not publish video: $e');
        }
      }

      await requestBackgroundPermission();
    }

    if (lkPlatformIsWebMobile()) {
      await context.showErrorDialog('Screen share is not supported on mobile web');
      return;
    }
    await room!.localParticipant!.setScreenShareEnabled(true, captureScreenAudio: true);
  }

  void _sortParticipants() {
    List<ParticipantTrack> userMediaTracks = [];
    List<ParticipantTrack> screenTracks = [];
    for (var participant in (room?.remoteParticipants.values ?? <RemoteParticipant>[])) {
      if (participant.videoTrackPublications.any((e) => e.isScreenShare)) {
        screenTracks.add(
          ParticipantTrack(
            participant: participant,
            type: MediaType.screen,
          ),
        );
      }
    }

    userMediaTracks.sort((a, b) {
      if (a.participant.isSpeaking && b.participant.isSpeaking) {
        if (a.participant.audioLevel > b.participant.audioLevel) {
          return -1;
        } else {
          return 1;
        }
      }

      final aSpokeAt = a.participant.lastSpokeAt?.millisecondsSinceEpoch ?? 0;
      final bSpokeAt = b.participant.lastSpokeAt?.millisecondsSinceEpoch ?? 0;

      if (aSpokeAt != bSpokeAt) {
        return aSpokeAt > bSpokeAt ? -1 : 1;
      }

      if (a.participant.hasVideo != b.participant.hasVideo) {
        return a.participant.hasVideo ? -1 : 1;
      }

      return a.participant.joinedAt.millisecondsSinceEpoch - b.participant.joinedAt.millisecondsSinceEpoch;
    });

    setState(() {
      participantTracks = [...screenTracks, ...userMediaTracks];
    });
  }

  Future<void> _connect() async {
    setState(() => _busy = true);

    var url = /*widget.link.isEmpty ?*/ 'wss://coretik.coretech-mena.com' /*: widget.link*/;

    var token = /*widget.token.isEmpty ?*/ tTest /*: widget.token*/;

    try {
      var screenEncoding = const VideoEncoding(
        maxBitrate: 3 * 1000 * 1000,
        maxFramerate: 15,
      );

      room = Room(
        roomOptions: RoomOptions(
          adaptiveStream: true,
          dynacast: true,
          defaultAudioPublishOptions: const AudioPublishOptions(
            name: 'custom_audio_track_name',
          ),
          defaultCameraCaptureOptions: const CameraCaptureOptions(
            maxFrameRate: 30,
            params: VideoParameters(
              dimensions: VideoDimensions(1280, 720),
            ),
          ),
          defaultScreenShareCaptureOptions: const ScreenShareCaptureOptions(
            useiOSBroadcastExtension: true,
            params: VideoParameters(
              dimensions: VideoDimensionsPresets.h1080_169,
            ),
          ),
          defaultVideoPublishOptions: VideoPublishOptions(
            simulcast: true,
            videoCodec: 'H264',
            backupVideoCodec: BackupVideoCodec(
              enabled: false,
            ),
            screenShareEncoding: screenEncoding,
          ),
        ),
      );
      // Create a Listener before connecting
      listener = room?.createListener();

      await room?.prepareConnection(url, token);

      await room?.connect(
        url,
        token,
        fastConnectOptions: FastConnectOptions(),
      );
      setState(() {
        _connected = true;
        _busy = false;
      });

      room?.addListener(_sortParticipants);
      _setUpListeners();
      _sortParticipants();
    } catch (error) {
      NoteMessage.showErrorDialog(context, text: error.toString());
    } finally {
      setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: !widget.isOpen
              ? 0.0.verticalSpace
              : Container(
                  alignment: Alignment.center,
                  constraints: BoxConstraints(minHeight: 0.2.sh, maxHeight: 0.4.sh, minWidth: 1.0.sw),
                  child: _busy
                      ? Center(
                          child: MyStyle.loadingWidget(),
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (!_connected)
                              MyButton(
                                onTap: _connect,
                                text: 'Connect',
                              )
                            else
                              Builder(builder: (context) {
                                final item = participantTracks.isNotEmpty
                                    ? participantTracks.first
                                    : ParticipantTrack(
                                        participant: room!.localParticipant!,
                                        type: MediaType.media,
                                      );
                                return AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: DynamicUser(participantTrack: item),
                                );
                              }),
                            if (room != null && room!.localParticipant != null)
                              ControlsWidget(
                                room!,
                                room!.localParticipant!,
                                onFullScreen: () {
                                  showFullScreenDialog();
                                },
                              ),
                          ],
                        ),
                )),
    );
  }
}

class _Temp extends StatelessWidget {
  const _Temp({super.key, required this.item});

  final ParticipantTrack item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          height: 1.0.sh,
          width: 1.0.sw,
          child: RotatedBox(
            quarterTurns: 1, // تدوير للشاشة (90 درجة)
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: DynamicUser(participantTrack: item),
            ),
          ),
        ),
      ),
    );
  }
}

const tTest =
    'eyJhbGciOiJIUzI1NiJ9.eyJuYW1lIjoic2FlZCAxIiwiYXR0cmlidXRlcyI6eyJsa1VzZXJUeXBlIjoiMiJ9LCJ2aWRlbyI6eyJyb29tSm9pbiI6dHJ1ZSwiY2FuUHVibGlzaCI6dHJ1ZSwiY2FuU3Vic2NyaWJlIjp0cnVlLCJjYW5QdWJsaXNoRGF0YSI6dHJ1ZSwicm9vbSI6Im0zIn0sImlzcyI6IkFQSWVTRmlWN3hpQ1J6UiIsImV4cCI6MTc1OTY3NDQ4NywibmJmIjowLCJzdWIiOiJ1c2VyMSJ9.yMQvpv9SpJixqOQmbodFB1oDVBLctRny53BsaIHjAtA';
