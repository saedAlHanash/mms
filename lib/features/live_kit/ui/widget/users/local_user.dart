import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/widgets/my_card_widget.dart';

import '../../../../../core/strings/enum_manager.dart';
import '../no_video.dart';
import '../participant_info.dart';
import '../sound_waveform.dart';

class LocalUser extends StatefulWidget {
  const LocalUser({super.key, required this.participantTrack});

  final ParticipantTrack participantTrack;

  @override
  State<LocalUser> createState() => _LocalUserState();
}

class _LocalUserState extends State<LocalUser> {
  LocalParticipant get participant => widget.participantTrack.participant as LocalParticipant;

  MediaType get type => widget.participantTrack.type;

  LocalTrackPublication<LocalVideoTrack>? get videoPublication =>
      participant.videoTrackPublications.where((e) => e.source == type.videoSourceType).firstOrNull;

  LocalTrackPublication<LocalAudioTrack>? get audioPublication =>
      participant.audioTrackPublications.where((e) => e.source == type.audioSourceType).firstOrNull;

  VideoTrack? get activeVideoTrack => videoPublication?.track;

  AudioTrack? get activeAudioTrack => audioPublication?.track;

  bool get videoActive => activeVideoTrack != null && !activeVideoTrack!.muted;

  bool get audioActive => activeAudioTrack != null && !activeAudioTrack!.muted;

  @override
  void initState() {
    super.initState();
    participant.addListener(_onParticipantChanged);
    _onParticipantChanged();
  }

  @override
  void dispose() {
    participant.removeListener(_onParticipantChanged);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LocalUser oldWidget) {
    oldWidget.participantTrack.participant.removeListener(_onParticipantChanged);
    participant.addListener(_onParticipantChanged);
    _onParticipantChanged();
    super.didUpdateWidget(oldWidget);
  }

  void _onParticipantChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext ctx) {
    return Stack(
      children: [
        videoActive
            ? MyCardWidget(
                margin: EdgeInsets.all(20.0).r,
                radios: 20.0,
                child: VideoTrackRenderer(
                  renderMode: VideoRenderMode.auto,
                  activeVideoTrack!,
                ),
              )
            : const NoVideoWidget(),
        Align(
          alignment: Alignment.bottomCenter,
          child: ParticipantInfoWidget(
            title: participant.displayName,
            connectionQuality: participant.connectionQuality,
            enabledE2EE: participant.isEncrypted,
          ),
        ),
        if (activeAudioTrack != null)
          Padding(
            padding: const EdgeInsets.all(20.0).r,
            child: Align(
                alignment: Alignment.topRight,
                child: SoundWaveformWidget(
                  key: ValueKey(activeAudioTrack!.hashCode),
                  audioTrack: activeAudioTrack!,
                  width: 8,
                )),
          ),
      ],
    );
  }
}
