part of 'temp_cubit.dart';

class TempInitial extends AbstractState<Temp> {



  const TempInitial({
    required super.result,
    super.error,
    required super.request,
    // required this.tempParam,
    super.statuses,
  });

  factory TempInitial.initial() {
    return TempInitial(
      result: Temp.fromJson({}),
      error: '',
      // tempParam: false,
      request: '',
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

  TempInitial copyWith({
    CubitStatuses? statuses,
    Temp? result,
    String? error,
    String? request,
    // bool? tempParam,
  }) {
    return TempInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
      // tempParam: tempParam ?? this.tempParam,
    );
  }
}
