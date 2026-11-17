import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mms/features/meeting_hub/data/response/hub_message_response.dart';
import 'package:mms/services/meeting_hub_service.dart';
import 'package:signalr_netcore/signalr_client.dart';

part 'meeting_hub_state.dart';

/// Owns the SignalR connection of the open meeting and exposes its status
/// and incoming messages to the meeting screen.
class MeetingHubCubit extends Cubit<MeetingHubInitial> {
  MeetingHubCubit() : super(MeetingHubInitial.initial());

  MeetingHubService? _service;

  //region UI Methods

  /// Connects to the meeting hub (once per cubit / meeting).
  Future<void> start({required String meetingId, required String partyId}) async {
    if (_service != null || meetingId.isEmpty) return;
    _service = MeetingHubService(
      meetingId: meetingId,
      partyId: partyId,
      onMessage: _onMessage,
      onResync: _requestResync,
      onStatusChanged: _onStatus,
    );
    await _service!.connect();
  }

  /// App went to the background: close the socket (the OS would drop it anyway).
  Future<void> pause() async => _service?.disconnect();

  /// Back to the foreground: reconnect and ask the screen to refetch.
  Future<void> resume() async {
    await _service?.connect();
    _requestResync();
  }

  /// Manual retry from the status chip.
  Future<void> retry() => resume();

  //endregion

  void _onMessage(HubMessage message) {
    if (isClosed) return;
    emit(state.copyWith(lastMessage: message, messageId: state.messageId + 1));
  }

  void _onStatus(HubConnectionState connectionState) {
    if (isClosed) return;
    final status = HubStatus.fromConnection(connectionState);
    if (status != state.status) emit(state.copyWith(status: status));
  }

  void _requestResync() {
    if (isClosed) return;
    emit(state.copyWith(resyncId: state.resyncId + 1));
  }

  @override
  Future<void> close() async {
    final service = _service;
    _service = null;
    await service?.disconnect();
    return super.close();
  }
}
