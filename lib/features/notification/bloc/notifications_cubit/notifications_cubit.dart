import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/api_manager/request_models/command.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/enum_manager.dart';
import 'package:m_cubit/abstraction.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/notification_response.dart';

part 'notifications_state.dart';

class NotificationsCubit extends MCubit<NotificationsInitial> {
  NotificationsCubit() : super(NotificationsInitial.initial());

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

//
// Future<void> setCount() async {
//   await AppSharedPreference.setNotificationsRead(state.result.length);
//   emit(state.copyWith(numOfRead: state.result.length));
// }
}
