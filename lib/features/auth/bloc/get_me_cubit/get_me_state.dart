part of 'get_me_cubit.dart';

class LoggedPartyInitial extends AbstractCubit<Party> {
  // final LoggedPartyRequest request;
  // final bool loggedPartyParam;

  const LoggedPartyInitial({
    required super.result,
    super.error,
    // required this.request,
    // required this.loggedPartyParam,
    super.statuses,
  });

  factory LoggedPartyInitial.initial() {
    return LoggedPartyInitial(
      result: Party.fromJson({}),
      error: '',
      // loggedPartyParam: false,
      // request: LoggedPartyRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  LoggedPartyInitial copyWith({
    CubitStatuses? statuses,
    Party? result,
    String? error,
    // LoggedPartyRequest? request,
    // bool? loggedPartyParam,
  }) {
    return LoggedPartyInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      // request: request ?? this.request,
      // loggedPartyParam: loggedPartyParam ?? this.loggedPartyParam,
    );
  }
}
