part of 'member_cubit.dart';

class MemberInitial extends AbstractState<Member> {
  // final MemberRequest request;
  // final bool tempParam;

  const MemberInitial({
    required super.result,
    super.error,
    // required this.request,
    // required this.tempParam,
    super.statuses,
  });

  factory MemberInitial.initial() {
    return MemberInitial(
      result: Member.fromJson({}),
      error: '',
      // tempParam: false,
      // request: MemberRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  MemberInitial copyWith({
    CubitStatuses? statuses,
    Member? result,
    String? error,
    // MemberRequest? request,
    // bool? tempParam,
  }) {
    return MemberInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      // request: request ?? this.request,
      // tempParam: tempParam ?? this.tempParam,
    );
  }
}
