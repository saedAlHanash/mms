part of 'agora_cubit.dart';

class AgoraInitial extends AbstractState<Agora> {
  const AgoraInitial({
    required super.result,
    super.error,
    required super.request,
    super.statuses,
    super.id,
  });

  factory AgoraInitial.initial() {
    return AgoraInitial(
      result: Agora.fromJson({}),
      request: '',
      
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
      ];
      
  AgoraInitial copyWith({
    CubitStatuses? statuses,
    Agora? result,
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

   