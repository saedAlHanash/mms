import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/features/live_kit/ui/widget/users/remote_user.dart';

import 'local_user.dart';

class DynamicUser extends StatelessWidget {
  const DynamicUser({super.key, required this.participant, this.fit = VideoViewFit.contain});

  final VideoViewFit fit;
  final Participant participant;

  @override
  Widget build(BuildContext context) {
    if (participant is LocalParticipant) {
      return LocalUser(participant: participant);
    } else if (participant is RemoteParticipant) {
      return RemoteUser(participant: participant);
    }
    throw UnimplementedError('Unknown participant type');
  }
}

class UserImageOrName extends StatelessWidget {
  const UserImageOrName({super.key, required this.participant, this.size = 60.0});

  final Participant participant;
  final double size;

  @override
  Widget build(BuildContext context) {
    return (!participant.image.isBlank)
        ? ImageMultiType(
            url: participant.image,
            fit: BoxFit.cover,
            height: size,
            width: size,
          )
        : Container(
            height: size,
            width: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: participant.sid.colorFromId),
            ),
            alignment: AlignmentGeometry.center,
            child: DrawableText(
              text: participant.displayName.firstCharacter.toUpperCase(),
              size: 24.0.sp,
            ),
          );
  }
}
