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
