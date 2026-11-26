import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';

import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/error/error_manager.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/core/util/pair_class.dart';

part 'add_absence_state.dart';

/// A member's absence request (`AbsenceRequest/Add { partyId, meetingId, comment }`).
/// The meeting page refetches the meeting when it's done.
class AddAbsenceCubit extends Cubit<AddAbsenceInitial> {
  AddAbsenceCubit() : super(AddAbsenceInitial.initial());

  Future<bool> addAbsence({required String meetingId, required String comment}) async {
    if (state.statuses.loading) return false;
    emit(state.copyWith(statuses: CubitStatuses.loading));

    final pair = await _send(meetingId, comment);
    if (isClosed) return false;
    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
      return false;
    }
    emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    return true;
  }

  Future<Pair<bool?, String?>> _send(String meetingId, String comment) async {
    final response = await APIService().callApi(
      type: ApiType.post,
      url: PostUrl.addAbsence,
      body: {
        "partyId": AppProvider.getParty.id,
        "meetingId": meetingId,
        "comment": comment.trim(),
      },
    );

    if (response.statusCode.success) {
      return Pair(true, null);
    } else {
      return response.getPairError;
    }
  }
}
