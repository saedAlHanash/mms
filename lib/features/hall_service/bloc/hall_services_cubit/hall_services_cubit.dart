import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/error/error_manager.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/features/hall_service/data/response/hall_service_response.dart';

part 'hall_services_state.dart';

/// A meeting's hall service requests (`HallServiceRequest/GetList`), adding and cancelling.
class HallServicesCubit extends Cubit<HallServicesInitial> {
  HallServicesCubit() : super(HallServicesInitial.initial());

  //region getData
  Future<void> getData({String? meetingId}) async {
    final id = meetingId ?? state.meetingId;
    if (id.isEmpty) return;
    emit(state.copyWith(statuses: CubitStatuses.loading, meetingId: id));

    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.hallServices,
      query: {'meetingId': id},
    );
    if (isClosed) return;

    if (response.statusCode.success) {
      final list = response.jsonBody['data'] is List ? response.jsonBody['data'] as List : const [];
      emit(
        state.copyWith(
          statuses: CubitStatuses.done,
          result: _sorted(list.whereType<Map<String, dynamic>>().map(HallServiceRequest.fromJson).toList()),
        ),
      );
    } else {
      emit(state.copyWith(statuses: CubitStatuses.error, error: response.getPairError.second));
    }
  }
  //endregion

  //region CRUD
  /// Hospitality (with the number of people) or another service; both need details.
  Future<bool> add({required HallServiceKind kind, required int quantity, required String details}) async {
    if (state.sending) return false;
    emit(state.copyWith(sending: true));

    final response = await APIService().callApi(
      type: ApiType.post,
      url: PostUrl.addHallService,
      body: {
        'meetingId': state.meetingId,
        'kind': kind.index,
        'quantity': quantity.clamp(0, 999),
        'details': details.trim(),
      },
    );
    if (isClosed) return false;

    if (response.statusCode.success) {
      final added = HallServiceRequest.fromJson(response.jsonBody);
      emit(state.copyWith(sending: false, result: added.isEmpty ? null : _sorted([added, ...state.result])));
      if (added.isEmpty) getData();
      return true;
    }
    emit(state.copyWith(sending: false, statuses: CubitStatuses.error, error: response.getPairError.second));
    showErrorFromApi(state);
    return false;
  }

  Future<bool> cancel(String id) async {
    if (state.cancellingId.isNotEmpty) return false;
    emit(state.copyWith(cancellingId: id));

    final response = await APIService().callApi(type: ApiType.put, url: PutUrl.cancelHallService, body: {'id': id});
    if (isClosed) return false;

    if (response.statusCode.success) {
      final updated = HallServiceRequest.fromJson(response.jsonBody);
      emit(
        state.copyWith(
          cancellingId: '',
          result: updated.isEmpty ? null : _sorted([for (final e in state.result) e.id == id ? updated : e]),
        ),
      );
      if (updated.isEmpty) getData();
      return true;
    }
    emit(state.copyWith(cancellingId: '', statuses: CubitStatuses.error, error: response.getPairError.second));
    showErrorFromApi(state);
    return false;
  }
  //endregion

  /// Open ones first, then newest.
  static List<HallServiceRequest> _sorted(List<HallServiceRequest> items) => items.sorted((a, b) {
    if (a.isOpen != b.isOpen) return a.isOpen ? -1 : 1;
    return (b.requestedAt ?? DateTime(0)).compareTo(a.requestedAt ?? DateTime(0));
  });
}
