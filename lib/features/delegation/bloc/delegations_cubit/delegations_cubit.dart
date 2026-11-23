import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/error/error_manager.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/features/delegation/data/request/delegation_requests.dart';
import 'package:mms/features/delegation/data/response/delegation_response.dart';

part 'delegations_state.dart';

/// A committee's role delegations (`Delegation/GetList`), adding one and revoking.
class DelegationsCubit extends Cubit<DelegationsInitial> {
  DelegationsCubit() : super(DelegationsInitial.initial());

  //region getData
  Future<void> getData({String? committeeId}) async {
    final id = committeeId ?? state.committeeId;
    if (id.isEmpty) return;
    emit(state.copyWith(statuses: CubitStatuses.loading, committeeId: id));

    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.delegations,
      query: {'committeeId': id},
    );
    if (isClosed) return;

    if (response.statusCode.success) {
      final body = response.jsonBody;
      final list = body['data'] is List ? body['data'] as List : const [];
      final items = list.whereType<Map<String, dynamic>>().map(Delegation.fromJson).toList();
      emit(state.copyWith(statuses: CubitStatuses.done, result: _sorted(items)));
    } else {
      // Quiet: the section stays as it was.
      emit(state.copyWith(statuses: CubitStatuses.error, error: response.getPairError.second));
    }
  }
  //endregion

  //region CRUD
  /// Returns true when the delegation was recorded.
  Future<bool> add(AddDelegationRequest request) async {
    if (state.sending) return false;
    emit(state.copyWith(sending: true));

    final response = await APIService().callApi(
      type: ApiType.post,
      url: PostUrl.addDelegation,
      body: request.toJson(),
    );
    if (isClosed) return false;

    if (response.statusCode.success) {
      final added = Delegation.fromJson(response.jsonBody);
      emit(state.copyWith(sending: false, result: added.isEmpty ? null : _sorted([added, ...state.result])));
      if (added.isEmpty) getData();
      return true;
    }

    emit(state.copyWith(sending: false, statuses: CubitStatuses.error, error: response.getPairError.second));
    showErrorFromApi(state);
    return false;
  }

  Future<bool> revoke(String id) async {
    if (state.revokingId.isNotEmpty) return false;
    emit(state.copyWith(revokingId: id));

    final response = await APIService().callApi(
      type: ApiType.put,
      url: PutUrl.revokeDelegation,
      body: {'id': id},
    );
    if (isClosed) return false;

    if (response.statusCode.success) {
      final updated = Delegation.fromJson(response.jsonBody);
      emit(
        state.copyWith(
          revokingId: '',
          result: updated.isEmpty ? null : _sorted([for (final e in state.result) e.id == id ? updated : e]),
        ),
      );
      if (updated.isEmpty) getData();
      return true;
    }

    emit(state.copyWith(revokingId: '', statuses: CubitStatuses.error, error: response.getPairError.second));
    showErrorFromApi(state);
    return false;
  }
  //endregion

  /// Active first, then upcoming, then the rest; newest first within each.
  static List<Delegation> _sorted(List<Delegation> items) => items.sorted((a, b) {
    final byState = a.state.order.compareTo(b.state.order);
    if (byState != 0) return byState;
    return (b.startsAt ?? DateTime(0)).compareTo(a.startsAt ?? DateTime(0));
  });
}
