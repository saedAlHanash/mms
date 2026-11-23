import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/features/check_in/data/response/check_in_code_response.dart';

part 'check_in_code_state.dart';

/// The hall QR for the secretary's tablet (`CheckIn/GetCode`).
/// Fetches a new code when `secondsLeft` runs out; retries every few seconds on failure.
class CheckInCodeCubit extends Cubit<CheckInCodeInitial> {
  CheckInCodeCubit() : super(CheckInCodeInitial.initial());

  static const _retryAfter = Duration(seconds: 5);

  Timer? _next;

  //region getData
  Future<void> start(String meetingId) async {
    if (meetingId.isEmpty) return;
    emit(state.copyWith(meetingId: meetingId, statuses: CubitStatuses.loading));
    await getData();
  }

  Future<void> getData() async {
    _next?.cancel();
    if (state.meetingId.isEmpty) return;

    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.checkInCode,
      query: {'meetingId': state.meetingId},
    );
    if (isClosed) return;

    if (response.statusCode.success) {
      final code = CheckInCode.fromJson(response.jsonBody);
      emit(state.copyWith(statuses: CubitStatuses.done, result: code, fetchedAt: DateTime.now()));
      // A second of slack so the server has rotated when we ask again.
      final wait = code.secondsLeft > 0 ? code.secondsLeft + 1 : code.periodSeconds;
      _next = Timer(Duration(seconds: wait), getData);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.error, error: response.getPairError.second));
      // Keep trying while a code was already on screen (e.g. a network blip).
      if (!state.result.isEmpty) _next = Timer(_retryAfter, getData);
    }
  }
  //endregion

  @override
  Future<void> close() {
    _next?.cancel();
    return super.close();
  }
}
