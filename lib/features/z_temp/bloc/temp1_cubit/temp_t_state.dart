part of 'temp_t_cubit.dart';

class TempInitial extends AbstractCubit<List<TempModel>> {
  // final TempRequest request;
  // final  bool tempParam;
  const TempInitial({
    required super.result,
    required super.filterRequest,
    super.error,
    // required this.request,
    // required this.tempParam,
    super.statuses,
  });//

  factory TempInitial.initial() {
    return const TempInitial(
      result: [],
      filterRequest: null,
      error: '',
      // tempParam: false,
      // request: TempRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];


  TempInitial copyWith({
    CubitStatuses? statuses,
    List<TempModel>? result,
    FilterRequest? filterRequest,
    String? error,
    // TempRequest? request,
    // bool? tempParam,
  }) {
    return TempInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      filterRequest: filterRequest ?? this.filterRequest,
      error: error ?? this.error,
      // request: request ?? this.request,
      // tempParam: tempParam ?? this.tempParam,
    );
  }
}
