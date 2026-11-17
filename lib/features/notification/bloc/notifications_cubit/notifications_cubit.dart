import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';

import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/core/util/pair_class.dart';
import 'package:mms/core/util/shared_preferences.dart';
import 'package:mms/features/notification/data/response/notification_response.dart';

part 'notifications_state.dart';

class NotificationsCubit extends MCubit<NotificationsInitial> {
  NotificationsCubit() : super(NotificationsInitial.initial());
  @override
  get mState => state;
  @override
  String get nameCache => 'notifications';

  @override
  String get filter => (state.filterRequest?.getKey) ?? state.request ?? '';

  Future<void> getData({bool newData = false}) async {
    getDataAbstract(
      fromJson: NotificationModel.fromJson,
      state: state,
      newData: newData,
      getDataApi: _getNotifications,
    );
  }

  Future<Pair<List<NotificationModel>?, String?>> _getNotifications() async {
    final response = await APIService().callApi(
      type: ApiType.post,
      url: PostUrl.notifications,
      body: state.filterRequest?.toJson() ?? {},
    );

    if (response.statusCode.success) {
      return Pair(Notifications.fromJson(response.jsonBodyPure).items, null);
    } else {
      return response.getPairError;
    }
  }

  //region UI Methods

  /// Marks every loaded notification as seen (clears the unread badge).
  Future<void> markAllAsRead() async {
    final ids = {...state.readIds, ...state.result.map((e) => e.id)};
    if (ids.length == state.readIds.length) return;
    emit(state.copyWith(readIds: ids));
    await AppSharedPreference.cashReadNotifications(ids);
  }

  //endregion
}
