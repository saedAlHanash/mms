part of 'my_committees_cubit.dart';

class MyCommitteesInitial extends AbstractState<List<Committee>> {
  // final MyCommitteesRequest request;
  // final  bool myCommitteesParam;
  const MyCommitteesInitial({
    required super.result,
    super.error,
    // required this.request,
    // required this.myCommitteesParam,
    super.statuses,
  }); //

  factory MyCommitteesInitial.initial() {
    return const MyCommitteesInitial(
      result: [],
      error: '',
      // myCommitteesParam: false,
      // request: MyCommitteesRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  MyCommitteesInitial copyWith({
    CubitStatuses? statuses,
    List<Committee>? result,
    String? error,
    // MyCommitteesRequest? request,
    // bool? myCommitteesParam,
  }) {
    return MyCommitteesInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      // request: request ?? this.request,
      // myCommitteesParam: myCommitteesParam ?? this.myCommitteesParam,
    );
  }
}
