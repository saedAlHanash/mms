part of 'members_cubit.dart';

class MembersInitial extends AbstractState<List<Member>> {
  // final MembersRequest request;
  // final  bool tempParam;
  const MembersInitial({
    required super.result,
    super.error,
    // required this.request,
    // required this.tempParam,
    super.statuses,
  }); //

  factory MembersInitial.initial() {
    return const MembersInitial(
      result: [],
      error: '',
      // tempParam: false,
      // request: MembersRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  MembersInitial copyWith({
    CubitStatuses? statuses,
    List<Member>? result,
    String? error,
    // MembersRequest? request,
    // bool? tempParam,
  }) {
    return MembersInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      // request: request ?? this.request,
      // tempParam: tempParam ?? this.tempParam,
    );
  }
}
