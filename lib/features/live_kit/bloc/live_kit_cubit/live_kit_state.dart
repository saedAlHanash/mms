part of 'live_kit_cubit.dart';

class LiveKitInitial extends AbstractState<LiveKit> {
  const LiveKitInitial({
    required super.result,
    super.error,
    required super.request,
    super.statuses,
    super.id,
  });

  factory LiveKitInitial.initial() {
    return LiveKitInitial(
      result: LiveKit.fromJson({}),
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
      
  LiveKitInitial copyWith({
    CubitStatuses? statuses,
    LiveKit? result,
    String? error,
    dynamic id,
    String? request,
  }) {
    return LiveKitInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      id: id ?? this.id,
      request: request ?? this.request,
    );
  }
}

   