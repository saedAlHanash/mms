part of 'create_temp_cubit.dart';

class CreateTempInitial extends AbstractState<Temp> {
  const CreateTempInitial({
    required super.result,
    super.error,
    required super.request,
    super.statuses,
  }); //

  CreateTempRequest get mRequest => request;

  factory CreateTempInitial.initial() {
    return CreateTempInitial(
      result: Temp.fromJson({}),
      error: '',
      request: CreateTempRequest.fromJson({}),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [
    statuses,
    result,
    error,
    if (request != null) request,
    if (filterRequest != null) filterRequest!
  ];

  CreateTempInitial copyWith({
    CubitStatuses? statuses,
    Temp? result,
    String? error,
    CreateTempRequest? request,
  }) {
    return CreateTempInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
