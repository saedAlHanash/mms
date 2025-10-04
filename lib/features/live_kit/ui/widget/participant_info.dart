import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../../../core/strings/enum_manager.dart';

extension ParticipantTrackTypeExt on MediaType {}

class ParticipantTrack {
  ParticipantTrack({
    required this.participant,
    this.type = MediaType.media,
  });

  Participant participant;
  final MediaType type;
}

class ParticipantInfoWidget extends StatelessWidget {
  const ParticipantInfoWidget({
    this.title,
    this.connectionQuality = ConnectionQuality.unknown,
    this.enabledE2EE = false,
    super.key,
  });

  final String? title;
  final ConnectionQuality connectionQuality;

  final bool enabledE2EE;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.3),
      padding: const EdgeInsets.symmetric(
        vertical: 7,
        horizontal: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DrawableText(text: title ?? ''),
          10.0.horizontalSpace,
          connectionQuality.icon,
          10.0.horizontalSpace,
        ],
      ),
    );
  }
}
