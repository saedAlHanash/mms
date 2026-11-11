import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:livekit_client/livekit_client.dart' as client;
import 'package:livekit_client/livekit_client.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/core/util/snack_bar_message.dart';
import 'package:mms/generated/l10n.dart';
import 'package:mms/core/util/exts.dart';
import 'package:mms/features/room/bloc/room_cubit/room_cubit.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/widgets/menu_widget.dart';
import '../../../../main.dart';
import '../../data/request/setting_message.dart';

class ControlsWidget extends StatefulWidget {
  const ControlsWidget(
    this.room,
    this.participant, {
    super.key,
    this.onFullScreen,
  });

  //
  final Room room;
  final LocalParticipant participant;
  final VoidCallback? onFullScreen;

  @override
  State<StatefulWidget> createState() => _ControlsWidgetState();
}

class _ControlsWidgetState extends State<ControlsWidget> {
  @override
  void initState() {
    super.initState();
    participant.addListener(_onChange);
  }

  @override
  void dispose() {
    participant.removeListener(_onChange);
    super.dispose();
  }

  LocalParticipant get participant => widget.participant;

  void _onChange() {
    // trigger refresh
    setState(() {});
  }

  bool get isMuted => participant.isMuted;

  void _disableAudio() async {
    await participant.setMicrophoneEnabled(false);
  }

  Future<void> _enableAudio() async {
    await participant.setMicrophoneEnabled(true);
  }

  void _disableVideo() async {
    await participant.setCameraEnabled(
      false,
    );
  }

  void _enableVideo() async {
    if (await Permission.camera.isGranted) {
      await participant.setCameraEnabled(
        true,
      );
    } else {
      await Permission.camera.request();
    }
  }

  void _onFullScreen() {
    widget.onFullScreen?.call();
  }

  void _enableScreenShare() async {
    if (lkPlatformIsDesktop()) {
      try {
        final source = await showDialog<DesktopCapturerSource>(
          context: context,
          builder: (context) => ScreenSelectDialog(),
        );

        if (source == null) return;

        var track = await LocalVideoTrack.createScreenShareTrack(
          ScreenShareCaptureOptions(sourceId: source.id, maxFrameRate: 15.0),
        );
        await participant.publishVideoTrack(track);
      } catch (e) {
        print('could not publish video: $e');
      }
      return;
    }
    if (lkPlatformIs(PlatformType.android)) {
      // Android specific
      final hasCapturePermission = await Helper.requestCapturePermission();
      if (!hasCapturePermission) return;

      requestBackgroundPermission([bool isRetry = false]) async {
        // Required for android screenshare.
        try {
          var hasPermissions = await FlutterBackground.hasPermissions;

          if (!isRetry) {
            const androidConfig = FlutterBackgroundAndroidConfig(
              notificationTitle: 'Screen Sharing',
              notificationText: 'MMS is sharing the screen.',
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
    await participant.setScreenShareEnabled(true, captureScreenAudio: true);
  }

  void _disableScreenShare() async {
    await participant.setScreenShareEnabled(false);

    if (Platform.isAndroid) {
      try {
        await FlutterBackground.disableBackgroundExecution();
      } catch (error) {
        print('error disabling screen share: $error');
      }
    }
  }

  void _onTapDisconnect() async {
    // Same outcome as before: disconnect only after confirmation.
    await NoteMessage.showCheckDialog(
      context,
      text: S.of(context).endCallConfirm,
      description: S.of(context).endCallConfirmDescription,
      textButton: S.of(context).endCall,
      image: Icons.call_end_rounded,
      destructive: true,
      onConfirm: () => widget.room.disconnect(),
    );
  }

  /// Requested to speak in this session (display only).
  bool _requestSent = false;

  /// 44x44 control: white when on, `dangerSoft` when off, `danger` for end.
  Widget _control({
    required IconData icon,
    required String tooltip,
    required VoidCallback onPressed,
    Color background = AppColorManager.neutral0,
    Color foreground = AppColorManager.neutral900,
  }) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: background,
        borderRadius: BorderRadius.circular(10.0.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(10.0.r),
          onTap: onPressed,
          child: SizedBox(
            width: 44.0.r,
            height: 44.0.r,
            child: Center(
              child: ImageMultiType(url: icon, width: 20.0.r, height: 20.0.r, color: foreground),
            ),
          ),
        ),
      ),
    );
  }

  Widget _offControl({required IconData icon, required String tooltip, required VoidCallback onPressed}) {
    return _control(
      icon: icon,
      tooltip: tooltip,
      onPressed: onPressed,
      background: AppColorManager.dangerSoft,
      foreground: AppColorManager.dangerText,
    );
  }

  Widget _wideButton({
    required String text,
    required Color background,
    required Color foreground,
    required VoidCallback onPressed,
    Widget? icon,
  }) {
    return Material(
      color: background,
      borderRadius: BorderRadius.circular(10.0.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0.r),
        onTap: onPressed,
        child: SizedBox(
          height: 44.0.r,
          child: Center(
            child: DrawableText(
              text: text,
              size: 15.0.sp,
              fontWeight: .w700,
              color: foreground,
              maxLines: 1,
              drawablePadding: 8.0.w,
              drawableStart: icon,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomCubit, RoomInitial>(
      builder: (context, state) {
        final children = <Widget>[];

        final messages = Container(
          width: 44.0.r,
          height: 44.0.r,
          decoration: BoxDecoration(
            color: AppColorManager.neutral0,
            borderRadius: BorderRadius.circular(10.0.r),
          ),
          child: Tooltip(
            message: S.of(context).quickMessage,
            child: DynamicPopupMenu(
              icon: Icons.chat_bubble_outline_rounded,
              items: NotesMessages.values.map(
                (e) {
                  return PopupMenuItemModel(
                    icon: e.icon,
                    label: e.name,
                    onTap: () {
                      context.read<RoomCubit>().sendMessage(e.name);
                    },
                  );
                },
              ).toList(),
            ),
          ),
        );

        final fullscreen = _control(
          icon: Icons.fullscreen_rounded,
          tooltip: S.of(context).fullscreen,
          onPressed: _onFullScreen,
        );

        final end = _control(
          icon: Icons.call_end_rounded,
          tooltip: S.of(context).endCall,
          onPressed: _onTapDisconnect,
          background: AppColorManager.danger,
          foreground: AppColorManager.neutral0,
        );

        if (state.isSuspend) {
          // Suspended: only one wide "End call" button.
          children.add(
            Expanded(
              child: _wideButton(
                text: S.of(context).endCall,
                background: AppColorManager.danger,
                foreground: AppColorManager.neutral0,
                onPressed: _onTapDisconnect,
              ),
            ),
          );
        } else if (!participant.permissions.canPublish) {
          // Listen only: messages, fullscreen, request to speak, end.
          children.addAll([
            messages,
            fullscreen,
            Expanded(
              child: _wideButton(
                text: _requestSent ? S.of(context).requestSent : S.of(context).requestToSpeak,
                background: _requestSent ? AppColorManager.primary100 : AppColorManager.primary500,
                foreground: _requestSent ? AppColorManager.primary700 : AppColorManager.neutral0,
                icon: state.loadingPermissions
                    ? SizedBox(
                        width: 18.0.r,
                        height: 18.0.r,
                        child: const CircularProgressIndicator(strokeWidth: 2, color: AppColorManager.neutral0),
                      )
                    : ImageMultiType(
                        url: Icons.back_hand_outlined,
                        width: 18.0.r,
                        height: 18.0.r,
                        color: _requestSent ? AppColorManager.primary700 : AppColorManager.neutral0,
                      ),
                onPressed: () async {
                  context.read<RoomCubit>().raiseHand();
                  setState(() => _requestSent = true);
                },
              ),
            ),
            end,
          ]);
        } else {
          // Can publish: mic, camera, screen share, messages, fullscreen, end.
          children.addAll([
            if (participant.isMicrophoneEnabled())
              _control(icon: Icons.mic_none_rounded, tooltip: S.of(context).muteMic, onPressed: _disableAudio)
            else
              _offControl(icon: Icons.mic_off_rounded, tooltip: S.of(context).unmuteMic, onPressed: _enableAudio),
            if (participant.isCameraEnabled())
              _control(icon: Icons.videocam_outlined, tooltip: S.of(context).cameraOff, onPressed: _disableVideo)
            else
              _offControl(icon: Icons.videocam_off_outlined, tooltip: S.of(context).cameraOn, onPressed: _enableVideo),
            if (participant.isScreenShareEnabled())
              _control(
                icon: Icons.screen_share_outlined,
                tooltip: S.of(context).stopShare,
                onPressed: () => _disableScreenShare(),
              )
            else
              _offControl(
                icon: Icons.stop_screen_share_outlined,
                tooltip: S.of(context).shareScreen,
                onPressed: () => _enableScreenShare(),
              ),
            messages,
            fullscreen,
            end,
          ]);
        }

        final spaced = <Widget>[];
        for (var i = 0; i < children.length; i++) {
          if (i > 0) spaced.add(8.0.horizontalSpace);
          spaced.add(children[i]);
        }

        return Container(
          padding: EdgeInsets.all(6.0.r),
          decoration: BoxDecoration(
            color: AppColorManager.neutral50,
            borderRadius: BorderRadius.circular(12.0.r),
          ),
          child: Row(
            mainAxisAlignment: .center,
            children: spaced,
          ),
        );
      },
    );
  }
}
