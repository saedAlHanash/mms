part of 'agora_cubit.dart';

class AgoraInitial extends AbstractState<AgoraManager> {
  const AgoraInitial({
    required super.result,
    super.error,
    required super.request,
    super.statuses,
    super.id,
    required this.isMicrophoneMuted,
    required this.isSharingMuted,
    required this.isAllAudioMuted,
  });

  final bool isMicrophoneMuted;

  final bool isSharingMuted;

  final bool isAllAudioMuted;

  factory AgoraInitial.initial() {
    return AgoraInitial(
      result: AgoraManager.protectedConstructor(),
      request: '',
      id: 0,
      isMicrophoneMuted: false,
      isSharingMuted: false,
      isAllAudioMuted: false,
    );
  }

  bool get isJoin => result.isJoined;

  Color get color => isJoin ? Colors.green : AppColorManager.grey;

  @override
  List<Object> get props => [
        statuses,
        result,
        error,
        isMicrophoneMuted,
        isSharingMuted,
        isAllAudioMuted,
        if (request != null) request,
        if (id != null) id,
        if (filterRequest != null) filterRequest!,
      ];

  AgoraInitial copyWith({
    CubitStatuses? statuses,
    AgoraManager? result,
    String? error,
    dynamic id,
    String? request,
    bool? isMicrophoneMuted,
    bool? isSharingMuted,
    bool? isAllAudioMuted,
  }) {
    return AgoraInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      id: id ?? this.id,
      request: request ?? this.request,
      isMicrophoneMuted: isMicrophoneMuted ?? this.isMicrophoneMuted,
      isSharingMuted: isSharingMuted ?? this.isSharingMuted,
      isAllAudioMuted: isAllAudioMuted ?? this.isAllAudioMuted,
    );
  }
}
