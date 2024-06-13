part of 'notification_cubit.dart';

class NotificationInitial extends AbstractState<NotificationModel> {
  final String notificationId;
  // final bool notificationParam;

  const NotificationInitial({
    required super.result,
    super.error,
    required this.notificationId,
    // required this.notificationParam,
    super.statuses,
  });

  factory NotificationInitial.initial() {
    return NotificationInitial(
      result: NotificationModel.fromJson({}),
      error: '',
      // notificationParam: false,
      notificationId: '',
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

  NotificationInitial copyWith({
    CubitStatuses? statuses,
    NotificationModel? result,
    String? error,
    String? notificationId,
    // bool? notificationParam,
  }) {
    return NotificationInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      notificationId: notificationId ?? this.notificationId,
      // notificationParam: notificationParam ?? this.notificationParam,
    );
  }
}
