import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/error/error_manager.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/core/util/pair_class.dart';
import 'package:mms/features/interest/data/request/declare_interest_request.dart';
import 'package:mms/features/interest/data/response/interest_response.dart';

part 'meeting_interests_state.dart';

/// Conflict-of-interest disclosures of a meeting (`Interest/GetByMeeting`),
/// declaring one on an agenda item and withdrawing it.
class MeetingInterestsCubit extends Cubit<MeetingInterestsInitial> {
  MeetingInterestsCubit() : super(MeetingInterestsInitial.initial());

  //region getData
  Future<void> getData({String? meetingId}) async {
    final id = meetingId ?? state.meetingId;
    if (id.isEmpty) return;
    emit(state.copyWith(statuses: CubitStatuses.loading, meetingId: id));

    final pair = await _getDataApi(id);
    if (isClosed) return;

    if (pair.first == null) {
      // Older backends don't have it: the items just show no badge.
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<InterestDisclosure>?, String?>> _getDataApi(String meetingId) async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.interestsByMeeting,
      query: {'meetingId': meetingId},
    );

    if (response.statusCode.success) {
      final list = (response.jsonBody['data'] as List? ?? []);
      return Pair(list.map((e) => InterestDisclosure.fromJson(e)).toList(), null);
    } else {
      return response.getPairError;
    }
  }
  //endregion

  //region CRUD
  /// Declares my interest in [agendaItemId]; returns true when recorded.
  Future<bool> declare({required String agendaItemId, String note = ''}) async {
    if (state.sendingItemId.isNotEmpty) return false;
    emit(state.copyWith(sendingItemId: agendaItemId));

    final response = await APIService().callApi(
      type: ApiType.post,
      url: PostUrl.declareInterest,
      body: DeclareInterestRequest(agendaItemId: agendaItemId, note: note).toJson(),
    );
    if (isClosed) return false;

    if (response.statusCode.success) {
      final added = InterestDisclosure.fromJson(response.jsonBody);
      emit(state.copyWith(sendingItemId: '', result: [...state.result, added]));
      // The server answers with the record; refetch if it didn't.
      if (added.id.isEmpty) getData();
      return true;
    }

    emit(state.copyWith(sendingItemId: '', statuses: CubitStatuses.error, error: response.getPairError.second));
    showErrorFromApi(state);
    return false;
  }

  /// Withdraws my disclosure [disclosure]; returns true when removed.
  Future<bool> withdraw(InterestDisclosure disclosure) async {
    if (state.sendingItemId.isNotEmpty) return false;
    emit(state.copyWith(sendingItemId: disclosure.agendaItemId));

    final response = await APIService().callApi(
      type: ApiType.delete,
      url: DeleteUrl.withdrawInterest,
      query: {'id': disclosure.id},
    );
    if (isClosed) return false;

    if (response.statusCode.success) {
      emit(state.copyWith(sendingItemId: '', result: state.result.where((e) => e.id != disclosure.id).toList()));
      return true;
    }

    emit(state.copyWith(sendingItemId: '', statuses: CubitStatuses.error, error: response.getPairError.second));
    showErrorFromApi(state);
    return false;
  }
  //endregion

  //region UI Methods
  /// My disclosure on [agendaItemId], if any.
  InterestDisclosure? mineFor(String agendaItemId) {
    final myId = AppProvider.getParty.id;
    return state.result.firstWhereOrNull((e) => e.agendaItemId == agendaItemId && e.partyId == myId);
  }
  //endregion
}
