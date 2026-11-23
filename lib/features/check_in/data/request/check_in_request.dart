/// `CheckInScanDto`: the code read from the hall QR (or typed in).
class CheckInScanRequest {
  CheckInScanRequest({required this.meetingId, required this.code});

  final String meetingId;
  final String code;

  Map<String, dynamic> toJson() => {'meetingId': meetingId, 'code': code};
}

/// `JoinOnlineDto`: records a remote arrival before opening the online room.
class JoinOnlineRequest {
  JoinOnlineRequest({required this.meetingId});

  final String meetingId;

  Map<String, dynamic> toJson() => {'meetingId': meetingId};
}
