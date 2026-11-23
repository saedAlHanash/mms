import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/core/util/pair_class.dart';
import 'package:mms/features/circulation/data/request/circulation_requests.dart';
import 'package:mms/features/circulation/data/response/circulation_response.dart';

part 'circulations_state.dart';

/// A committee's decisions by circulation (`Circulation/GetList`), page by page.
/// The server lists open ones first, then the newest.
class CirculationsCubit extends Cubit<CirculationsInitial> {
  CirculationsCubit() : super(CirculationsInitial.initial());

  static const _pageSize = 20;

  //region getData
  /// Loads the first page again.
  Future<void> getData({String? committeeId}) async {
    final id = committeeId ?? state.committeeId;
    if (id.isEmpty) return;
    emit(state.copyWith(statuses: CubitStatuses.loading, committeeId: id));

    final pair = await _getPage(0);
    if (isClosed) return;

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(
        state.copyWith(
          statuses: CubitStatuses.done,
          result: pair.first!.items,
          totalCount: pair.first!.totalCount,
          page: 0,
        ),
      );
    }
  }

  Future<void> loadMore() async {
    if (state.loadingMore || state.loading || !state.hasMore) return;
    emit(state.copyWith(loadingMore: true));

    final pair = await _getPage(state.page + 1);
    if (isClosed) return;

    if (pair.first == null) {
      emit(state.copyWith(loadingMore: false));
      return;
    }
    final known = state.result.map((e) => e.id).toSet();
    emit(
      state.copyWith(
        loadingMore: false,
        page: state.page + 1,
        totalCount: pair.first!.totalCount,
        result: [...state.result, ...pair.first!.items.where((e) => !known.contains(e.id))],
      ),
    );
  }

  Future<Pair<CirculationPage?, String?>> _getPage(int page) async {
    final response = await APIService().callApi(
      type: ApiType.post,
      url: PostUrl.circulationList,
      body: CirculationListQuery(
        committeeId: state.committeeId,
        status: state.statusFilter,
        pageNumber: page,
        pageSize: _pageSize,
      ).toJson(),
    );

    if (response.statusCode.success) {
      return Pair(CirculationPage.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }
  //endregion

  //region UI Methods
  void setFilter(CirculationStatus? filter) {
    if (filter == state.statusFilter) return;
    emit(state.copyWith(statusFilter: () => filter, result: [], totalCount: 0));
    getData();
  }

  /// After voting on the details page.
  void replace(Circulation item) {
    emit(state.copyWith(result: [for (final e in state.result) e.id == item.id ? item : e]));
  }
  //endregion
}
