import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/api_manager/request_models/command.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../data/response/notification_response.dart';

part 'notifications_state.dart';

class NotificationsCubit extends MCubit<NotificationsInitial> {
  NotificationsCubit() : super(NotificationsInitial.initial());

  @override
  String get nameCache => 'notifications';

  @override
  String get filter => (state.filterRequest?.getKey) ?? state.request ?? '';

  Future<void> getNotifications({bool newData = false}) async {
    final checkData = await checkCashed1(
      state: state,
      fromJson: NotificationModel.fromJson,
      newData: newData,
    );

    if (checkData) return;

    final pair = await _getNotifications();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      await storeData(pair.first!);
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
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

  void setRequest(FilterRequest request) {
    emit(state.copyWith(filterRequest: request));
  }

  Future<bool> checkCashed() async {
    try {
      final cacheType = await needGetData();

      emit(
        state.copyWith(
          statuses: cacheType.getState,
          result: (await getListCached())
              .map((e) => NotificationModel.fromJson(e))
              .toList(),
        ),
      );

      if (cacheType == NeedUpdateEnum.no) return true;
      return false;
    } catch (e) {
      return false;
    }
  }
//
// Future<void> setCount() async {
//   await AppSharedPreference.setNotificationsRead(state.result.length);
//   emit(state.copyWith(numOfRead: state.result.length));
// }
}
