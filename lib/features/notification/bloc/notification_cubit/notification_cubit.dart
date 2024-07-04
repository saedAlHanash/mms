import 'package:mms/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/notification_response.dart';

part 'notification_state.dart';

class NotificationCubit extends MCubit<NotificationInitial> {
  NotificationCubit() : super(NotificationInitial.initial());

  @override
  String get nameCache => 'notification';

  @override
  String get filter => state.notificationId ?? '';

  Future<void> getNotification({required String notificationId}) async {
    emit(state.copyWith(notificationId: notificationId));
    if (await checkCashed()) return;

    final pair = await _getNotification();
    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      await storeData(pair.first!);
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<NotificationModel?, String?>> _getNotification() async {
    final response = await APIService().callApi(type: ApiType.get,
      url: 'GetUrl.notification',
      query: {'Id': state.notificationId},
    );

    if (response.statusCode.success) {
      return Pair(NotificationModel.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }

  Future<bool> checkCashed() async {
        try {
    final cacheType = await needGetData();

    emit(
      state.copyWith(
        statuses: cacheType.getState,
        result: NotificationModel.fromJson(await getDataCached()),
      ),
    );

    if (cacheType == NeedUpdateEnum.no) return true;
    return false;
        } catch (e) {
      return false;
    }
  }
}
