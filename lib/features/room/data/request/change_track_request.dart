import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mms/features/room/bloc/room_cubit/room_cubit.dart';

import '../../../../core/app/app_widget.dart';

class ChangeTrackRequest {
  ChangeTrackRequest({
    required this.identity,
    required this.trackSid,
  });

  final String identity;
  final String trackSid;

  factory ChangeTrackRequest.fromJson(Map<String, dynamic> json) {
    return ChangeTrackRequest(
      identity: json["identity"] ?? "",
      trackSid: json["track_sid"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "room": ctx?.read<RoomCubit>().state.result.name ?? '',
        "identity": identity,
        "track_sid": trackSid,
        "muted": true,
      };
}
