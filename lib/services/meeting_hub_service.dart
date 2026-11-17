import 'dart:async';

import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/features/meeting_hub/data/response/hub_message_response.dart';
import 'package:signalr_netcore/signalr_client.dart';

/// Live updates for one open meeting through the CoreTech SignalR hub.
///
/// Listen-only: the app never sends meeting events to the hub; changes go
/// through the REST API and the API broadcasts them to the meeting's topic.
///
/// - One connection per meeting (`{hub}/{meetingId}`), no auth header.
/// - `ReceiveMessage` is registered once, before `start()`.
/// - `JoinTopic(meetingId, partyId)` after start and after every reconnect.
/// - [onResync] is called after a reconnect so the screen can refetch what
///   it missed (the hub doesn't replay messages).
class MeetingHubService {
  MeetingHubService({
    required this.meetingId,
    required this.partyId,
    required this.onMessage,
    required this.onResync,
    this.onStatusChanged,
  });

  final String meetingId;
  final String partyId;
  final void Function(HubMessage message) onMessage;
  final void Function() onResync;

  /// Connection state changes, for showing the live status on screen.
  final void Function(HubConnectionState state)? onStatusChanged;

  HubConnection? _hub;
  StreamSubscription<HubConnectionState>? _stateSubscription;
  Timer? _retryTimer;
  int _retryAttempt = 0;

  static const _retryDelays = [Duration(seconds: 2), Duration(seconds: 5), Duration(seconds: 10)];

  bool get isConnected => _hub?.state == HubConnectionState.Connected;

  /// Opens the connection and joins the meeting topic. Safe to call twice.
  Future<void> connect() async {
    if (_hub != null || meetingId.isEmpty) return;

    final hub = HubConnectionBuilder().withUrl('${HubUrl.meetingHub}$meetingId').withAutomaticReconnect().build();

    hub.on(HubUrl.receiveMessage, _onReceive);
    _stateSubscription = hub.stateStream.listen((state) => onStatusChanged?.call(state));
    hub.onreconnected(({connectionId}) async {
      await _join(hub);
      onResync();
    });

    _hub = hub;
    onStatusChanged?.call(HubConnectionState.Connecting);

    try {
      await hub.start();
      await _join(hub);
      _retryAttempt = 0;
    } catch (e) {
      loggerObject.w('Meeting hub: start failed ($e)');
      await _closeHub();
      _scheduleRetry();
    }
  }

  /// Stops the connection (screen closed or app in background).
  Future<void> disconnect() async {
    _retryTimer?.cancel();
    _retryTimer = null;
    _retryAttempt = 0;
    await _closeHub();
  }

  Future<void> _join(HubConnection hub) async {
    try {
      await hub.invoke(HubUrl.joinTopic, args: [meetingId, partyId]);
    } catch (e) {
      loggerObject.w('Meeting hub: JoinTopic failed ($e)');
    }
  }

  void _onReceive(List<Object?>? arguments) {
    if (arguments == null || arguments.isEmpty) return;

    final message = HubMessage.tryParse(arguments.first);
    if (message == null) {
      loggerObject.w('Meeting hub: bad message ${arguments.first}');
      return;
    }

    // Unknown events from a newer backend are ignored.
    if (message.event == null) return;
    onMessage(message);
  }

  /// The first start isn't covered by automatic reconnect, so retry it a few times.
  void _scheduleRetry() {
    if (_retryAttempt >= _retryDelays.length) return;
    final delay = _retryDelays[_retryAttempt++];
    onStatusChanged?.call(HubConnectionState.Reconnecting);
    _retryTimer?.cancel();
    _retryTimer = Timer(delay, () async {
      await connect();
      if (isConnected) onResync();
    });
  }

  Future<void> _closeHub() async {
    final hub = _hub;
    _hub = null;
    if (hub == null) return;
    await _stateSubscription?.cancel();
    _stateSubscription = null;
    onStatusChanged?.call(HubConnectionState.Disconnected);
    hub.off(HubUrl.receiveMessage);
    try {
      await hub.stop();
    } catch (e) {
      loggerObject.w('Meeting hub: stop failed ($e)');
    }
  }
}
