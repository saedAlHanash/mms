part of 'agora_cubit.dart';

class AgoraInitial extends AbstractState<AgoraManager> {
  const AgoraInitial({
    required super.result,
    super.error,
    required super.request,
    super.statuses,
    super.id,
  });

  factory AgoraInitial.initial() {
    return AgoraInitial(
      result: AgoraManager.protectedConstructor(),
      request: '',
      id: 0,
    );
  }

  bool get isJoin => result.isJoined;

  Color get color => isJoin ? Colors.green : AppColorManager.grey;

  @override
  List<Object> get props => [
        statuses,
        result,
        error,
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
  }) {
    return AgoraInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      id: id ?? this.id,
      request: request ?? this.request,
    );
  }
}
