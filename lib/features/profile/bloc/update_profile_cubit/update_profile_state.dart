part of 'update_profile_cubit.dart';

class UpdateProfileInitial extends AbstractState<bool> {
  final UpdatePartyRequest request;

  // final  bool educationalGradeParam;
  const UpdateProfileInitial({
    required super.result,
    super.error,
    required this.request,
    // required this.educationalGradeParam,
    super.statuses,
  }); //

  factory UpdateProfileInitial.initial() {
    return UpdateProfileInitial(
      result: false,
      error: '',
      // educationalGradeParam: false,
      request: UpdatePartyRequest.fromJson(AppProvider.getParty.toJson()),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  UpdateProfileInitial copyWith(
      {CubitStatuses? statuses,
      bool? result,
      String? error,
      UpdatePartyRequest? request}) {
    return UpdateProfileInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
