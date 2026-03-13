part of 'user_control_cubit.dart';

class UserControlInitial extends AbstractState<String> {
  const UserControlInitial({
    required super.result,
    super.error,
    required super.request,
    super.statuses,
    super.createUpdateRequest,
    super.id,
  });

  ChangeTrackRequest get mRequest => request;

  UpdateParticipantRequest get updateRequest => createUpdateRequest;

  factory UserControlInitial.initial() {
    return UserControlInitial(
      result: '',
      request: ChangeTrackRequest.fromJson({}),
      createUpdateRequest: UpdateParticipantRequest.fromJson({}),
    );
  }

  @override
  List<Object> get props => [
        statuses,
        result,
        error,
        if (request != null) request,
        if (createUpdateRequest != null) createUpdateRequest,
        if (id != null) id,
        if (filterRequest != null) filterRequest!,
      ];

  UserControlInitial copyWith({
    CubitStatuses? statuses,
    String? result,
    String? error,
    dynamic id,
    ChangeTrackRequest? request,
    UpdateParticipantRequest? updateRequest,
  }) {
    return UserControlInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      id: id ?? this.id,
      request: request ?? this.request,
      createUpdateRequest: updateRequest ?? createUpdateRequest,
    );
  }
}
