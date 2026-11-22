import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/error/error_manager.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/core/util/pair_class.dart';
import 'package:mms/core/util/shared_preferences.dart';
import 'package:mms/features/notice_preferences/data/response/notice_preferences_response.dart';

part 'notice_preferences_state.dart';

/// Push on/off for the signed-in person, kept on the server
/// (`Party/GetMyNoticePreferences`, `Party/UpdateMyNoticePreferences`).
class NoticePreferencesCubit extends Cubit<NoticePreferencesInitial> {
  NoticePreferencesCubit() : super(NoticePreferencesInitial.initial());

  //region getData
  Future<void> getData() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));

    final pair = await _getDataApi();

    if (pair.first == null) {
      // Not a blocking error: the switch keeps the cached value.
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      AppSharedPreference.cashNotificationState(pair.first!.allPush);
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<NoticePreferences?, String?>> _getDataApi() async {
    final response = await APIService().callApi(type: ApiType.get, url: GetUrl.noticePreferences);

    if (response.statusCode.success) {
      return Pair(NoticePreferences.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }
  //endregion

  //region CRUD
  /// Turns push on or off for every notice group.
  Future<bool> setPush(bool push) async {
    // Groups left out are kept by the server, so nothing loaded means nothing to send.
    if (state.result.groups.isEmpty) {
      AppSharedPreference.cashNotificationState(push);
      return true;
    }

    final updated = state.result.withPush(push);
    final response = await APIService().callApi(
      type: ApiType.put,
      url: PutUrl.updateNoticePreferences,
      body: updated.toJson(),
    );

    if (response.statusCode.success) {
      AppSharedPreference.cashNotificationState(push);
      emit(state.copyWith(statuses: CubitStatuses.done, result: updated));
      return true;
    }

    emit(state.copyWith(statuses: CubitStatuses.error, error: response.getPairError.second));
    showErrorFromApi(state);
    return false;
  }
  //endregion
}
