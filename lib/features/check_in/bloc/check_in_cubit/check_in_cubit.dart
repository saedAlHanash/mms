import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/error/error_manager.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/core/util/pair_class.dart';
import 'package:mms/features/check_in/data/request/check_in_request.dart';
import 'package:mms/features/check_in/data/response/check_in_response.dart';

part 'check_in_state.dart';

/// Hall check-in with the rotating six-digit code (`CheckIn/Scan`).
class CheckInCubit extends Cubit<CheckInInitial> {
  CheckInCubit() : super(CheckInInitial.initial());

  //region CRUD
  Future<void> scan({required String meetingId, required String code}) async {
    if (state.statuses == CubitStatuses.loading) return;
    emit(state.copyWith(statuses: CubitStatuses.loading));

    final pair = await _post(PostUrl.checkInScan, CheckInScanRequest(meetingId: meetingId, code: code).toJson());
    if (isClosed) return;

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  /// Records a remote arrival (`CheckIn/JoinOnline`). Never blocks joining the
  /// room: failures (in-person meeting, older backend) are only logged.
  static Future<void> joinOnline(String meetingId) async {
    if (meetingId.isEmpty) return;
    final pair = await _post(PostUrl.joinOnline, JoinOnlineRequest(meetingId: meetingId).toJson());
    if (pair.first == null) loggerObject.w('JoinOnline failed: ${pair.second}');
  }

  static Future<Pair<CheckInResult?, String?>> _post(String url, Map<String, dynamic> body) async {
    final response = await APIService().callApi(type: ApiType.post, url: url, body: body);

    if (response.statusCode.success) {
      return Pair(CheckInResult.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }
  //endregion
}
