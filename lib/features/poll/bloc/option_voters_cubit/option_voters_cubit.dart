import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/features/poll/data/response/option_voter_response.dart';

part 'option_voters_state.dart';

/// Who chose each option of a poll (`Vote/GetOptionVoters`): the chair and the
/// secretary once the poll is closed, everyone once the result is published.
class OptionVotersCubit extends Cubit<OptionVotersInitial> {
  OptionVotersCubit() : super(OptionVotersInitial.initial());

  Future<void> getData(List<String> optionIds) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, error: ''));

    final answers = await Future.wait(optionIds.map(_voters));
    if (isClosed) return;

    final failed = answers.where((e) => e.$2 != null);
    if (failed.isNotEmpty) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: failed.first.$2));
      return;
    }
    emit(state.copyWith(
      statuses: CubitStatuses.done,
      result: {for (var i = 0; i < optionIds.length; i++) optionIds[i]: answers[i].$1},
    ));
  }

  Future<(List<OptionVoter>, String?)> _voters(String optionId) async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.optionVoters,
      query: {'OptionId': optionId},
    );
    if (!response.statusCode.success) return (const <OptionVoter>[], response.getPairError.second);

    // A bare list, or wrapped in `data`.
    Object? body;
    try {
      body = jsonDecode(response.body);
    } catch (_) {}
    final raw = body is Map ? body['data'] : body;
    final list = raw is List ? raw : const [];
    return (list.whereType<Map<String, dynamic>>().map(OptionVoter.fromJson).toList(), null);
  }
}
