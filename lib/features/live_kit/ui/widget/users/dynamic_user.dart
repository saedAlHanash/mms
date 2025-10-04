import 'package:flutter/material.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:mms/features/live_kit/ui/widget/users/remote_user.dart';

import '../participant_info.dart';
import 'local_user.dart';

class DynamicUser extends StatelessWidget {
  const DynamicUser({super.key, required this.participantTrack});

  final ParticipantTrack participantTrack;

  @override
  Widget build(BuildContext context) {
    if (participantTrack.participant is LocalParticipant) {
      return LocalUser(participantTrack: participantTrack);
    } else if (participantTrack.participant is RemoteParticipant) {
      return InteractiveViewer(
        minScale: 1,
        maxScale: 4.0,
        panEnabled: true,
        child: RemoteUser(participantTrack: participantTrack),
      );
    }
    throw UnimplementedError('Unknown participant type');
  }
}
