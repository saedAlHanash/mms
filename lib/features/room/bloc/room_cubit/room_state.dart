part of 'room_cubit.dart';

class RoomInitial extends AbstractState<Room> {
  const RoomInitial({
    required super.result,
    super.error,
    required super.request,
    super.statuses,
    super.id,
    required this.url,
    required this.token,
    required this.listener,
    required this.participantTracks,
    required this.raiseHands,
    required this.selectedUserId,
  });

  final String url;

  final String token;

  int get notifyIndex => id ?? 0;

  final EventsListener<RoomEvent> listener;

  final Set<String> raiseHands;

  final List<Participant> participantTracks;

  final String selectedUserId;

  List<Participant> get participantTracksWithoutSelected =>
      participantTracks.where((e) => e.sid != selectedParticipant?.sid).toList(growable: false);

  Participant? get selectedParticipant =>
      participantTracks.firstWhereOrNull((e) => e.sid == selectedUserId) ?? participantTracks.firstOrNull;

  ConnectionState get connectionState => result.connectionState;

  bool get isConnect => result.connectionState == ConnectionState.connected;

  factory RoomInitial.initial() {
    final room = Room();
    return RoomInitial(
      id: 0,
      result: room,
      request: '',
      url: '',
      // url: 'wss://coretik.coretech-mena.com',
      token: '',
      listener: room.createListener(),
      raiseHands: {},
      participantTracks: const [],
      selectedUserId: '',
    );
  }

  @override
  List<Object> get props => [
        statuses,
        result,
        error,
        if (request != null) request,
        if (id != null) id,
        if (filterRequest != null) filterRequest!,
        listener,
        url,
        token,
        participantTracks,
        raiseHands,
        selectedUserId,
      ];

  RoomInitial copyWith(
      {CubitStatuses? statuses,
      Room? result,
      String? error,
      int? id,
      String? request,
      String? url,
      String? token,
      EventsListener<RoomEvent>? listener,
      List<Participant>? participantTracks,
      Set<String>? raiseHands,
      String? selectedUserId}) {
    return RoomInitial(
        statuses: statuses ?? this.statuses,
        result: result ?? this.result,
        error: error ?? this.error,
        id: id ?? this.id,
        request: request ?? this.request,
        url: url ?? this.url,
        token: token ?? this.token,
        listener: listener ?? this.listener,
        participantTracks: participantTracks ?? this.participantTracks,
        raiseHands: raiseHands ?? this.raiseHands,
        selectedUserId: selectedUserId ?? this.selectedUserId);
  }
}
