part of 'notifications_cubit.dart';

class NotificationsInitial extends AbstractState<List<NotificationModel>> {
  final  int numOfRead;
  // final FilterRequest request;
  // final  bool notificationParam;
  const NotificationsInitial({
    required super.result,
    required this.numOfRead,
    super.error,
    super.request,
    // required this.notificationParam,
    super.filterRequest,
    super.statuses,
  }); //

  factory NotificationsInitial.initial() {
    return  NotificationsInitial(
      result: [],
      numOfRead: 0,
      error: '',
      filterRequest: null,
      // notificationParam: false,
      // request: FilterRequest(),
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

  NotificationsInitial copyWith({
    CubitStatuses? statuses,
    List<NotificationModel>? result,
    int? numOfRead,
    String? error,
    FilterRequest? filterRequest,
    dynamic request,
  }) {
    return NotificationsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      numOfRead: numOfRead ?? this.numOfRead,
      error: error ?? this.error,
      filterRequest: filterRequest ?? this.filterRequest,
      request: request ?? this.request,
      // notificationParam: notificationParam ?? this.notificationParam,
    );
  }
}
