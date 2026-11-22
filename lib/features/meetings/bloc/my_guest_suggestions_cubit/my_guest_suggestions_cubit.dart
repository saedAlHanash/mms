import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/error/error_manager.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/core/util/pair_class.dart';
import 'package:mms/features/meetings/data/response/guest_suggestion_response.dart';
import 'package:mms/features/meetings/data/response/meetings_response.dart';

part 'my_guest_suggestions_state.dart';

/// The guest suggestions the signed-in person made for a meeting
/// (`Meeting/GetGuestSuggestions` returns only one's own for a member),
/// and withdrawing them (`Meeting/DeleteGuestSuggestion`).
class MyGuestSuggestionsCubit extends Cubit<MyGuestSuggestionsInitial> {
  MyGuestSuggestionsCubit() : super(MyGuestSuggestionsInitial.initial());

  //region getData
  Future<void> getData({String? meetingId}) async {
    final id = meetingId ?? state.meetingId;
    if (id.isEmpty) return;
    emit(state.copyWith(statuses: CubitStatuses.loading, meetingId: id));

    final pair = await _getDataApi(id);

    if (pair.first == null) {
      // Older backends don't have this endpoint: just no withdraw buttons.
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<GuestSuggestionItem>?, String?>> _getDataApi(String meetingId) async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.guestSuggestions,
      query: {'meetingId': meetingId},
    );

    if (response.statusCode.success) {
      final list = (response.jsonBody['data'] as List? ?? []);
      return Pair(list.map((e) => GuestSuggestionItem.fromJson(e)).toList(), null);
    } else {
      return response.getPairError;
    }
  }
  //endregion

  //region CRUD
  /// Withdraws [id]; returns true when it was removed.
  Future<bool> delete(String id) async {
    emit(state.copyWith(deletingId: id));

    final response = await APIService().callApi(
      type: ApiType.delete,
      url: DeleteUrl.guestSuggestion,
      query: {'id': id},
    );

    if (response.statusCode.success) {
      emit(state.copyWith(deletingId: '', result: state.result.where((e) => e.id != id).toList()));
      return true;
    }

    emit(state.copyWith(deletingId: '', statuses: CubitStatuses.error, error: response.getPairError.second));
    showErrorFromApi(state);
    return false;
  }
  //endregion

  //region UI Methods
  /// My suggestion matching a guest shown on the meeting, if any.
  GuestSuggestionItem? mineFor(Guest guest) {
    return state.result.firstWhereOrNull((e) => e.matches(guest));
  }
  //endregion
}
