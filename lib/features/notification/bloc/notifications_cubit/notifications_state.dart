part of 'notifications_cubit.dart';

class NotificationsInitial extends AbstractState<List<NotificationModel>> {
  /// Ids of notifications already seen (persisted), used for the unread badge.
  final Set<String> readIds;
  // final FilterRequest request;
  // final  bool notificationParam;
  final FilterRequest filterRequest;
  const NotificationsInitial({
    required super.result,
    required this.readIds,
    super.error,
    super.request,
    // required this.notificationParam,

    required this.filterRequest,
    super.statuses,
  }); //

  factory NotificationsInitial.initial() {
    return  NotificationsInitial(
      result: [],
      readIds: AppSharedPreference.getReadNotifications,
      error: '',

      filterRequest: FilterRequest(),
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
        readIds,

    filterRequest!,
      ];

  NotificationsInitial copyWith({
    CubitStatuses? statuses,
    List<NotificationModel>? result,
    Set<String>? readIds,
    String? error,

    FilterRequest? filterRequest,
    dynamic request,
  }) {
    return NotificationsInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      readIds: readIds ?? this.readIds,
      error: error ?? this.error,

      filterRequest: filterRequest ?? this.filterRequest,
      request: request ?? this.request,
      // notificationParam: notificationParam ?? this.notificationParam,
    );
  }

  /// Notifications not seen yet.
  int get unreadCount => result.where((e) => !readIds.contains(e.id)).length;
}
