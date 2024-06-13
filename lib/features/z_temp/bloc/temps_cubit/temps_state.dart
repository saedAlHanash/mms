part of 'temps_cubit.dart';

class TempsInitial extends AbstractState<List<Temp>> {
  const TempsInitial({
    required super.result,
    super.error,
    super.request,
    super.filterRequest,
    super.statuses,
  }); //

  factory TempsInitial.initial() {
    return const TempsInitial(
      result: [],
      error: '',
      filterRequest: null,
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

  TempsInitial copyWith({
    CubitStatuses? statuses,
    List<Temp>? result,
    String? error,
    FilterRequest? filterRequest,
    dynamic request,
  }) {
    return TempsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      filterRequest: filterRequest ?? this.filterRequest,
      request: request ?? this.request,
    );
  }
}
