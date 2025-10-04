part of 'live_kits_cubit.dart';

class LiveKitsInitial extends AbstractState<List<LiveKit>> {
  const LiveKitsInitial({
    required super.result,
    super.error,
    super.request,
    super.filterRequest,
    super.cubitCrud,
    super.createUpdateRequest,
    super.statuses,
    super.id,
  });

  factory LiveKitsInitial.initial() {
    return  LiveKitsInitial(
      result: [],
      createUpdateRequest: CreateLiveKitRequest.fromJson({}),
    );
  }

  CreateLiveKitRequest get cRequest => createUpdateRequest;

  String get mId => id;

  @override
  List<Object> get props => [
        statuses,
        result,
        error,
        cubitCrud,
        if (id != null) id,
        if (request != null) request,
        if (filterRequest != null) filterRequest!,
        if (createUpdateRequest != null) createUpdateRequest!,
      ];

  LiveKitsInitial copyWith({
    CubitStatuses? statuses,
    CubitCrud? cubitCrud,
    List<LiveKit>? result,
    String? error,
    FilterRequest? filterRequest,
    dynamic request,
    dynamic cRequest,
    dynamic id,
  }) {
    return LiveKitsInitial(
      statuses: statuses ?? this.statuses,
      cubitCrud: cubitCrud ?? this.cubitCrud,
      result: result ?? this.result,
      error: error ?? this.error,
      filterRequest: filterRequest ?? this.filterRequest,
      request: request ?? this.request,
      createUpdateRequest: cRequest ?? this.cRequest,
      id: id ?? this.id,
    );
  }
}

