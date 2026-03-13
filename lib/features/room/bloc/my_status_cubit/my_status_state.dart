part of 'my_status_cubit.dart';

class MyStatusInitial extends AbstractState<MyStatus> {
  const MyStatusInitial({
    required super.result,
    super.error,
    required super.request,
    super.statuses,
    super.id,
  });

  factory MyStatusInitial.initial() {
    final room = MyStatus.fromJson({});
    return MyStatusInitial(
      id: 0,
      result: room,
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

  MyStatusInitial copyWith({
    CubitStatuses? statuses,
    MyStatus? result,
    String? error,
    int? id,
    String? request,
  }) {
    return MyStatusInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      id: id ?? this.id,
      request: request ?? this.request,
    );
  }
}
