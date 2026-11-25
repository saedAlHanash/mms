import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/error/error_manager.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/features/sub_committee/data/response/sub_committee_response.dart';

part 'recommendations_state.dart';

/// A committee's place in the tree (`SubCommittee/GetTree`) and its recommendations
/// (`GetRecommendations`): raised to its parent, or received from its sub-committees.
class RecommendationsCubit extends Cubit<RecommendationsInitial> {
  RecommendationsCubit() : super(RecommendationsInitial.initial());

  //region getData
  Future<void> getData({String? committeeId}) async {
    final id = committeeId ?? state.committeeId;
    if (id.isEmpty) return;
    emit(state.copyWith(statuses: CubitStatuses.loading, committeeId: id));

    final (tree, recs) = await (
      APIService().callApi(type: ApiType.get, url: GetUrl.committeeTree, query: {'committeeId': id}),
      APIService().callApi(type: ApiType.get, url: GetUrl.recommendations, query: {'committeeId': id}),
    ).wait;
    if (isClosed) return;

    if (!recs.statusCode.success) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: recs.getPairError.second));
      return;
    }
    final list = recs.jsonBody['data'] is List ? recs.jsonBody['data'] as List : const [];
    emit(
      state.copyWith(
        statuses: CubitStatuses.done,
        result: _sorted(list.whereType<Map<String, dynamic>>().map(Recommendation.fromJson).toList()),
        // The tree is a nicety: without it the page just hides that card and "Raise".
        tree: tree.statusCode.success ? CommitteeTree.fromJson(tree.jsonBody) : null,
      ),
    );
  }
  //endregion

  //region CRUD
  Future<bool> raise({required String title, required String body}) async {
    if (state.sending) return false;
    emit(state.copyWith(sending: true));

    final response = await APIService().callApi(
      type: ApiType.post,
      url: PostUrl.raiseRecommendation,
      body: {'committeeId': state.committeeId, 'title': title.trim(), if (body.trim().isNotEmpty) 'body': body.trim()},
    );
    if (isClosed) return false;

    if (response.statusCode.success) {
      final added = Recommendation.fromJson(response.jsonBody);
      emit(state.copyWith(sending: false, result: added.isEmpty ? null : _sorted([added, ...state.result])));
      if (added.isEmpty) getData();
      return true;
    }
    emit(state.copyWith(sending: false, statuses: CubitStatuses.error, error: response.getPairError.second));
    showErrorFromApi(state);
    return false;
  }

  Future<bool> respond(String id, {required bool approve, String note = ''}) => _update(id, PutUrl.respondRecommendation, {
    'id': id,
    'approve': approve,
    if (note.trim().isNotEmpty) 'note': note.trim(),
  });

  Future<bool> withdraw(String id) => _update(id, PutUrl.withdrawRecommendation, {'id': id});

  Future<bool> _update(String id, String url, Map<String, dynamic> body) async {
    if (state.busyId.isNotEmpty) return false;
    emit(state.copyWith(busyId: id));

    final response = await APIService().callApi(type: ApiType.put, url: url, body: body);
    if (isClosed) return false;

    if (response.statusCode.success) {
      final updated = Recommendation.fromJson(response.jsonBody);
      emit(
        state.copyWith(
          busyId: '',
          result: updated.isEmpty ? null : _sorted([for (final e in state.result) e.id == id ? updated : e]),
        ),
      );
      if (updated.isEmpty) getData();
      return true;
    }
    emit(state.copyWith(busyId: '', statuses: CubitStatuses.error, error: response.getPairError.second));
    showErrorFromApi(state);
    return false;
  }
  //endregion

  /// Pending first, then newest.
  static List<Recommendation> _sorted(List<Recommendation> items) => items.sorted((a, b) {
    if (a.isPending != b.isPending) return a.isPending ? -1 : 1;
    return (b.raisedAt ?? DateTime(0)).compareTo(a.raisedAt ?? DateTime(0));
  });
}
