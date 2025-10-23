import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app/app_widget.dart';
import '../../bloc/room_cubit/room_cubit.dart';

class UpdateParticipantRequest {
  UpdateParticipantRequest({
    required this.identity,
    this.metadata,
    this.permission,
  });

  String identity;
  String? metadata;
  Permission? permission = Permission();

  factory UpdateParticipantRequest.fromJson(Map<String, dynamic> json) {
    return UpdateParticipantRequest(
      identity: json["identity"] ?? "",
      metadata: json["metadata"] ?? "",
      permission: Permission.fromJson(json["permission"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "room": ctx?.read<RoomCubit>().state.result.name ?? '',
        "identity": identity,
        "metadata": metadata,
        // "permission": permission?.toJson(),
      };
}

class Permission {
  Permission({
    this.canSubscribe = true,
    this.canPublish = true,
    this.canPublishData = true,
  });

  bool canSubscribe;
  bool canPublish;
  bool canPublishData;

  factory Permission.fromJson(Map<String, dynamic> json) {
    return Permission(
      canSubscribe: json["can_subscribe"] ?? true,
      canPublish: json["can_publish"] ?? true,
      canPublishData: json["can_publish_data"] ?? true,
    );
  }

  Map<String, dynamic> toJson() => {
        "can_subscribe": canSubscribe,
        "can_publish": canPublish,
        "can_publish_data": canPublishData,
      };
}
