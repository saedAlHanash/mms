import 'package:collection/collection.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/features/quorum/data/response/quorum_response.dart';

int _int(Object? v) => int.tryParse(v?.toString() ?? '') ?? 0;

int? _intOrNull(Object? v) => int.tryParse(v?.toString() ?? '');

/// `MeetingLiveStateDto` from `MeetingLive/GetState`.
class MeetingLiveState {
  MeetingLiveState({
    required this.meetingId,
    required this.title,
    required this.status,
    required this.serverNow,
    required this.canControl,
    required this.currentItem,
    required this.nextItem,
    required this.items,
    required this.quorum,
    required this.speakerLimitSeconds,
    required this.speaking,
    required this.waiting,
    required this.myRequest,
  });

  final String meetingId;
  final String title;
  final MeetingStatus status;

  /// Server clock at the time of the answer.
  final DateTime? serverNow;

  /// Show the chair / secretary controls.
  final bool canControl;

  final LiveItem? currentItem;
  final LiveItem? nextItem;
  final List<LiveItem> items;
  final MeetingQuorum? quorum;
  final int speakerLimitSeconds;
  final LiveSpeaker? speaking;

  /// Points of order first, then in the order asked.
  final List<LiveSpeaker> waiting;

  /// The signed-in person's open request (waiting or speaking).
  final LiveSpeaker? myRequest;

  bool get isEmpty => meetingId.isEmpty;

  /// 1-based place of my request in the queue, or 0.
  int get myPlace {
    final id = myRequest?.id;
    if (id == null) return 0;
    final index = waiting.indexWhere((e) => e.id == id);
    return index == -1 ? 0 : index + 1;
  }

  factory MeetingLiveState.empty() => MeetingLiveState.fromJson(const {});

  factory MeetingLiveState.fromJson(Map<String, dynamic> json) {
    LiveItem? item(Object? v) => v is Map<String, dynamic> ? LiveItem.fromJson(v) : null;
    LiveSpeaker? speaker(Object? v) => v is Map<String, dynamic> ? LiveSpeaker.fromJson(v) : null;
    final status = _int(json['status']);

    return MeetingLiveState(
      meetingId: json['meetingId'] ?? '',
      title: json['title'] ?? '',
      status: status < MeetingStatus.values.length ? MeetingStatus.values[status] : MeetingStatus.planned,
      serverNow: DateTime.tryParse(json['serverNow'] ?? ''),
      canControl: json['canControl'] ?? false,
      currentItem: item(json['currentItem']),
      nextItem: item(json['nextItem']),
      items: (json['items'] as List? ?? []).map((e) => LiveItem.fromJson(e)).toList(),
      quorum: json['quorum'] is Map<String, dynamic> ? MeetingQuorum.fromJson(json['quorum']) : null,
      speakerLimitSeconds: _int(json['speakerLimitSeconds']),
      speaking: speaker(json['speaking']),
      waiting: (json['waiting'] as List? ?? []).map((e) => LiveSpeaker.fromJson(e)).toList(),
      myRequest: speaker(json['myRequest']),
    );
  }
}

/// `LiveItemDto`: an agenda item with its server-side timer.
class LiveItem {
  LiveItem({required this.id, required this.title, required this.timer});

  final String id;
  final String title;
  final LiveTimer timer;

  factory LiveItem.fromJson(Map<String, dynamic> json) {
    return LiveItem(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      timer: LiveTimer.fromJson(json['timer'] is Map<String, dynamic> ? json['timer'] : const {}),
    );
  }
}

class LiveTimer {
  LiveTimer({
    required this.allottedSeconds,
    required this.elapsedSeconds,
    required this.running,
    required this.remainingSeconds,
  });

  /// 0: the item has no length, so the clock counts up.
  final int allottedSeconds;
  final int elapsedSeconds;
  final bool running;

  /// Negative once over time.
  final int remainingSeconds;

  bool get countsUp => allottedSeconds <= 0;

  factory LiveTimer.fromJson(Map<String, dynamic> json) {
    return LiveTimer(
      allottedSeconds: _int(json['allottedSeconds']),
      elapsedSeconds: _int(json['elapsedSeconds']),
      running: json['running'] ?? false,
      remainingSeconds: _int(json['remainingSeconds']),
    );
  }
}

/// `LiveSpeakerDto`: a request for the floor.
class LiveSpeaker {
  LiveSpeaker({
    required this.id,
    required this.partyId,
    required this.name,
    required this.kind,
    required this.state,
    required this.limitSeconds,
    required this.remainingSeconds,
  });

  final String id;
  final String partyId;
  final String name;
  final SpeakerRequestKind kind;
  final SpeakerRequestState state;
  final int limitSeconds;

  /// Null without a limit.
  final int? remainingSeconds;

  bool get isPointOfOrder => kind == SpeakerRequestKind.pointOfOrder;

  factory LiveSpeaker.fromJson(Map<String, dynamic> json) {
    return LiveSpeaker(
      id: json['id'] ?? '',
      partyId: json['partyId'] ?? '',
      name: json['name'] ?? '',
      kind: SpeakerRequestKind.values.elementAtOrNull(_int(json['kind'])) ?? SpeakerRequestKind.normal,
      state: SpeakerRequestState.values.elementAtOrNull(_int(json['state'])) ?? SpeakerRequestState.waiting,
      limitSeconds: _int(json['limitSeconds']),
      remainingSeconds: _intOrNull(json['remainingSeconds']),
    );
  }
}
