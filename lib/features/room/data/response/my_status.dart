class MyStatus {
  MyStatus({
    required this.room,
    required this.identity,
    required this.date,
    required this.state,
    required this.id,
  });

  final String room;
  final String identity;
  final DateTime? date;
  final State state;
  final String id;

  factory MyStatus.fromJson(Map<String, dynamic> json) {
    return MyStatus(
      room: json["room"] ?? "",
      identity: json["identity"] ?? "",
      date: DateTime.tryParse(json["date"] ?? ""),
      state: State.fromJson(json["state"] ?? {}),
      id: json["id"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "room": room,
        "identity": identity,
        "date": date?.toIso8601String(),
        "state": state?.toJson(),
        "id": id,
      };
}

class State {
  State({
    required this.canSubscribe,
    required this.canPublishData,
    required this.canPublish,
    required this.cameraMuted,
    required this.microphoneMuted,
    required this.screenShareMuted,
    required this.screenShareAudioMuted,
  });

  final bool canSubscribe;
  final bool canPublishData;
  final bool canPublish;
  final bool cameraMuted;
  final bool microphoneMuted;
  final bool screenShareMuted;
  final bool screenShareAudioMuted;

  factory State.fromJson(Map<String, dynamic> json) {
    return State(
      canSubscribe: json["canSubscribe"] ?? false,
      canPublishData: json["canPublishData"] ?? false,
      canPublish: json["canPublish"] ?? false,
      cameraMuted: json["cameraMuted"] ?? false,
      microphoneMuted: json["microphoneMuted"] ?? false,
      screenShareMuted: json["screenShareMuted"] ?? false,
      screenShareAudioMuted: json["screenShareAudioMuted"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "canSubscribe": canSubscribe,
        "canPublishData": canPublishData,
        "canPublish": canPublish,
        "cameraMuted": cameraMuted,
        "microphoneMuted": microphoneMuted,
        "screenShareMuted": screenShareMuted,
        "screenShareAudioMuted": screenShareAudioMuted,
      };
}
