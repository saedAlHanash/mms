part of 'committee_cubit.dart';

class CommitteeInitial extends AbstractState<Committee> {
  // final CommitteeRequest request;
  final String uuid;

  const CommitteeInitial({
    required super.result,
    super.error,
    // required this.request,
    required this.uuid,
    super.statuses,
  }); //

  factory CommitteeInitial.initial() {
    return CommitteeInitial(
      result: Committee.fromJson({}),
      error: '',
      uuid: '',
      // request: CommitteeRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  CommitteeInitial copyWith({
    CubitStatuses? statuses,
    Committee? result,
    String? error,
    // CommitteeRequest? request,
    String? uuid,
  }) {
    return CommitteeInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      // request: request ?? this.request,
      uuid: uuid ?? this.uuid,
    );
  }
}
