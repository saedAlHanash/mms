import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/widgets/my_card_widget.dart';

import '../no_video.dart';
import '../sound_waveform.dart';

class LocalUser extends StatefulWidget {
  const LocalUser({super.key, required this.participant});

  final Participant participant;

  @override
  State<LocalUser> createState() => _LocalUserState();
}

class _LocalUserState extends State<LocalUser> {
  @override
  void initState() {
    super.initState();
    widget.participant.addListener(_onParticipantChanged);
    _onParticipantChanged();
  }

  @override
  void dispose() {
    widget.participant.removeListener(_onParticipantChanged);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LocalUser oldWidget) {
    oldWidget.participant.localParticipant.removeListener(_onParticipantChanged);
    widget.participant.addListener(_onParticipantChanged);
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
        widget.participant.videoActive
            ? MyCardWidget(
                margin: EdgeInsets.all(20.0).r,
                radios: 20.0,
                child: VideoTrackRenderer(
                  renderMode: VideoRenderMode.auto,
                  fit: VideoViewFit.contain,
                  widget.participant.activeVideoTrack!,
                ),
              )
            : const NoVideoWidget(),
        if (widget.participant.activeAudioTrack != null)
          Padding(
            padding: const EdgeInsets.all(20.0).r,
            child: Align(
                alignment: Alignment.topRight,
                child: SoundWaveformWidget(
                  key: ValueKey(widget.participant.activeAudioTrack!.hashCode),
                  audioTrack: widget.participant.activeAudioTrack!,
                  width: 8,
                )),
          ),
      ],
    );
  }
}
