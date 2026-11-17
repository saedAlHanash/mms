// import 'package:flutter/material.dart';
// import 'package:livekit_client/livekit_client.dart';
//
// enum StatsType {
//   kUnknown,
//   kLocalAudioSender,
//   kLocalVideoSender,
//   kRemoteAudioReceiver,
//   kRemoteVideoReceiver,
// }
//
// class ParticipantStatsWidget extends StatefulWidget {
//   const ParticipantStatsWidget({super.key, required this.participant});
//   final Participant participant;
//   @override
//   State<StatefulWidget> createState() => _ParticipantStatsWidgetState();
// }
//
// class _ParticipantStatsWidgetState extends State<ParticipantStatsWidget> {
//   List<EventsListener<TrackEvent>> listeners = [];
//   StatsType statsType = StatsType.kUnknown;
//   Map<String, Map<String, String>> stats = {'audio': {}, 'video': {}};
//
//   _onParticipantChanged() {
//     for (var element in listeners) {
//       element.dispose();
//     }
//     listeners.clear();
//     for (var track in [...widget.participant.videoTrackPublications, ...widget.participant.audioTrackPublications]) {}
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     widget.participant.addListener(_onParticipantChanged);
//     // trigger initial change
//     _onParticipantChanged();
//   }
//
//   @override
//   void deactivate() {
//     for (var element in listeners) {
//       element.dispose();
//     }
//     widget.participant.removeListener(_onParticipantChanged);
//     super.deactivate();
//   }
//
//   num sendBitrate = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.black.withValues(alpha: 0.3),
//       padding: const EdgeInsets.symmetric(
//         vertical: 8,
//         horizontal: 8,
//       ),
//       child: Column(children: []),
//     );
//   }
// }
