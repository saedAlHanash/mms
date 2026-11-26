import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/error/error_manager.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/features/minutes/data/request/minute_approval_request.dart';
import 'package:mms/features/minutes/data/response/minute_approval_response.dart';

part 'minutes_state.dart';

/// A meeting's minutes approval: the path (`GetApprovalPath`), my answer
/// (`GetPartyApproval`), everyone's answers for the chair and the secretary
/// (`GetMinuteApprovals`), and approving / rejecting (`UpdateMinuteApproval`).
class MinutesCubit extends Cubit<MinutesInitial> {
  MinutesCubit() : super(MinutesInitial.initial());

  //region getData
  Future<void> getData({required String minuteId, required bool isLead}) async {
    if (minuteId.isEmpty) return;
    final first = state.result == null || state.minuteId != minuteId;
    emit(state.copyWith(
      statuses: first ? CubitStatuses.loading : state.statuses,
      minuteId: minuteId,
      isLead: isLead,
    ));

    final (path, mine, all) = await (
      _path(minuteId),
      _mine(minuteId),
      isLead ? _all(minuteId) : Future<List<MinuteApproval>?>.value(),
    ).wait;
    if (isClosed || state.minuteId != minuteId) return;

    if (path.$1 == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: path.$2 ?? ''));
      return;
    }
    emit(state.copyWith(
      statuses: CubitStatuses.done,
      result: path.$1,
      myAnswer: mine,
      clearMyAnswer: mine == null,
      approvals: all ?? const [],
    ));
  }

  Future<(MinuteApprovalPath?, String?)> _path(String minuteId) async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.minuteApprovalPath,
      query: {'minuteId': minuteId},
    );
    if (!response.statusCode.success) return (null, response.getPairError.second);
    final body = _decode(response.body);
    final map = body is Map<String, dynamic> && body['data'] is Map<String, dynamic> ? body['data'] : body;
    return (map is Map<String, dynamic> ? MinuteApprovalPath.fromJson(map) : null, null);
  }

  /// Null when I haven't answered, or the call failed (the section still works).
  Future<MinuteApproval?> _mine(String minuteId) async {
    final me = AppProvider.getParty.id;
    final response = await APIService().callApi(
      type: ApiType.post,
      url: PostUrl.partyMinuteApproval,
      body: {'partyId': me, 'minuteId': minuteId},
    );
    if (!response.statusCode.success) return null;
    var body = _decode(response.body);
    if (body is Map<String, dynamic> && body['data'] != null) body = body['data'];
    if (body is List && body.isNotEmpty) body = body.first;
    if (body is bool) return MinuteApproval(partyId: me, name: '', isApproved: body, reason: '');
    if (body is! Map<String, dynamic>) return null;
    final answer = MinuteApproval.fromJson(body);
    return answer.isApproved == null ? null : answer;
  }

  Future<List<MinuteApproval>?> _all(String minuteId) async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.minuteApprovals,
      query: {'minuteId': minuteId},
    );
    if (!response.statusCode.success) return null;
    var body = _decode(response.body);
    if (body is Map<String, dynamic>) body = body['data'] ?? body['items'];
    if (body is! List) return null;
    return body.whereType<Map<String, dynamic>>().map(MinuteApproval.fromJson).toList()
      // Not answered, then rejected, then approved.
      ..sort((a, b) => _rank(a).compareTo(_rank(b)));
  }

  static int _rank(MinuteApproval e) => switch (e.isApproved) {
        null => 0,
        false => 1,
        true => 2,
      };

  static Object? _decode(String body) {
    try {
      return jsonDecode(body);
    } catch (_) {
      return null;
    }
  }
  //endregion

  //region CRUD
  Future<bool> answer({required bool isApproved, String reason = ''}) async {
    if (state.sending || state.minuteId.isEmpty) return false;
    emit(state.copyWith(sending: true));

    final me = AppProvider.getParty.id;
    final response = await APIService().callApi(
      type: ApiType.post,
      url: PostUrl.updateMinuteApproval,
      body: UpdateMinuteApprovalRequest(
        partyId: me,
        minuteId: state.minuteId,
        isApproved: isApproved,
        reason: reason,
      ).toJson(),
    );
    if (isClosed) return false;

    if (response.statusCode.success) {
      emit(state.copyWith(
        sending: false,
        myAnswer: MinuteApproval(partyId: me, name: '', isApproved: isApproved, reason: reason),
      ));
      await getData(minuteId: state.minuteId, isLead: state.isLead);
      return true;
    }

    emit(state.copyWith(sending: false, statuses: CubitStatuses.error, error: response.getPairError.second));
    showErrorFromApi(state);
    // The section stays as it was after a refused answer.
    emit(state.copyWith(statuses: CubitStatuses.done));
    return false;
  }
  //endregion
}
