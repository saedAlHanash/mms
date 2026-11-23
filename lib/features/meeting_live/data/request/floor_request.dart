import 'package:mms/core/strings/enum_manager.dart';

/// `RequestFloorDto`.
class RequestFloorRequest {
  RequestFloorRequest({required this.meetingId, required this.pointOfOrder});

  final String meetingId;
  final bool pointOfOrder;

  Map<String, dynamic> toJson() => {'meetingId': meetingId, 'pointOfOrder': pointOfOrder};
}

/// `SpeakerIdDto` (withdraw a request).
class SpeakerIdRequest {
  SpeakerIdRequest({required this.id});

  final String id;

  Map<String, dynamic> toJson() => {'id': id};
}

/// `MeetingIdDto` (next speaker, end speaker).
class MeetingIdRequest {
  MeetingIdRequest({required this.meetingId});

  final String meetingId;

  Map<String, dynamic> toJson() => {'meetingId': meetingId};
}

/// `SetCurrentItemDto`: null [agendaItemId] clears the screen.
class SetCurrentItemRequest {
  SetCurrentItemRequest({required this.meetingId, required this.agendaItemId});

  final String meetingId;
  final String? agendaItemId;

  Map<String, dynamic> toJson() => {'meetingId': meetingId, 'agendaItemId': agendaItemId};
}

/// `SetTimerDto`.
class SetTimerRequest {
  SetTimerRequest({required this.agendaItemId, required this.action, this.seconds = 0});

  final String agendaItemId;
  final LiveTimerAction action;

  /// AddTime (negative takes time off) and SetLength only.
  final int seconds;

  Map<String, dynamic> toJson() => {'agendaItemId': agendaItemId, 'action': action.index, 'seconds': seconds};
}

/// `SetSpeakerLimitDto`: 0–3600 seconds, 0 means no limit.
class SetSpeakerLimitRequest {
  SetSpeakerLimitRequest({required this.meetingId, required this.seconds});

  final String meetingId;
  final int seconds;

  Map<String, dynamic> toJson() => {'meetingId': meetingId, 'seconds': seconds};
}
