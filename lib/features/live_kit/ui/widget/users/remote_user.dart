import 'package:flutter/material.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:livekit_client/livekit_client.dart';

import '../../../../../core/strings/enum_manager.dart';
import '../participant_info.dart';

class RemoteUser extends StatefulWidget {
  const RemoteUser({super.key, required this.participantTrack});

  final ParticipantTrack participantTrack;

  @override
  State<RemoteUser> createState() => _RemoteUserState();
}

class _RemoteUserState extends State<RemoteUser> {
  RemoteParticipant get participant => widget.participantTrack.participant as RemoteParticipant;

  MediaType get type => widget.participantTrack.type;

  RemoteTrackPublication<RemoteVideoTrack>? get videoPublication =>
      participant.videoTrackPublications.where((element) => element.source == type.videoSourceType).firstOrNull;

  RemoteTrackPublication<RemoteAudioTrack>? get audioPublication =>
      participant.audioTrackPublications.where((element) => element.source == type.audioSourceType).firstOrNull;

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
  void didUpdateWidget(covariant RemoteUser oldWidget) {
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
    return videoActive
        ? VideoTrackRenderer(
            renderMode: VideoRenderMode.auto,
            fit: VideoViewFit.contain,
            activeVideoTrack!,
          )
        : ImageMultiType(
            url: participant.attributes['imageUrl'],
            fit: BoxFit.contain,
          );
  }
}
