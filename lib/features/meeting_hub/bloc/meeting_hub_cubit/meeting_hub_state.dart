part of 'meeting_hub_cubit.dart';

/// What the meeting screen shows about the live-updates connection.
enum HubStatus {
  disconnected,
  connecting,
  connected,
  reconnecting;

  static HubStatus fromConnection(HubConnectionState state) => switch (state) {
        HubConnectionState.Connected => .connected,
        HubConnectionState.Connecting => .connecting,
        HubConnectionState.Reconnecting => .reconnecting,
        HubConnectionState.Disconnected || HubConnectionState.Disconnecting => .disconnected,
      };
}

class MeetingHubInitial {
  const MeetingHubInitial({
    this.status = .disconnected,
    this.lastMessage,
    this.messageId = 0,
    this.resyncId = 0,
  });

  final HubStatus status;

  /// Latest message received; [messageId] changes with every message so
  /// listeners react even when two messages are equal.
  final HubMessage? lastMessage;
  final int messageId;

  /// Changes whenever the screen should refetch (after a reconnect/resume).
  final int resyncId;

  factory MeetingHubInitial.initial() => const MeetingHubInitial();

  MeetingHubInitial copyWith({
    HubStatus? status,
    HubMessage? lastMessage,
    int? messageId,
    int? resyncId,
  }) {
    return MeetingHubInitial(
      status: status ?? this.status,
      lastMessage: lastMessage ?? this.lastMessage,
      messageId: messageId ?? this.messageId,
      resyncId: resyncId ?? this.resyncId,
    );
  }
}
