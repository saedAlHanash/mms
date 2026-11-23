import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/features/quorum/data/response/quorum_response.dart';

part 'quorum_state.dart';

/// A meeting's quorum outside the live panel (`Quorum/GetForMeeting`).
/// Refetched whenever the meeting reloads, since attendance may have changed.
class QuorumCubit extends Cubit<QuorumInitial> {
  QuorumCubit() : super(QuorumInitial.initial());

  //region getData
  Future<void> getData({String? meetingId}) async {
    final id = meetingId ?? state.meetingId;
    if (id.isEmpty) return;
    // Keep the last figure on screen while refreshing.
    emit(state.copyWith(statuses: CubitStatuses.loading, meetingId: id));

    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.quorumForMeeting,
      query: {'meetingId': id},
    );
    if (isClosed) return;

    if (response.statusCode.success) {
      emit(state.copyWith(statuses: CubitStatuses.done, result: MeetingQuorum.fromJson(response.jsonBody)));
    } else {
      // Quiet: the card just stays hidden.
      emit(state.copyWith(statuses: CubitStatuses.error, error: response.getPairError.second));
    }
  }
  //endregion
}
