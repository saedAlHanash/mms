import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/vote_response.dart';

part 'vote_state.dart';

class VoteCubit extends MCubit<VoteInitial> {
  VoteCubit() : super(VoteInitial.initial());

  @override
  String get nameCache => 'vote';

  @override
  String get filter => state.request ?? '';

  Future<void> getVote({bool newData = false, required String voteId}) async {
    emit(state.copyWith(request: voteId));
    final checkData = await checkCashed1(
        state: state, fromJson: Vote.fromJson, newData: newData);

    if (checkData) return;

    final pair = await _getVote();
    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      await storeData(pair.first!);
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<Vote?, String?>> _getVote() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.vote,
      query: {'Id': state.request},
    );

    if (response.statusCode.success) {
      return Pair(Vote.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }
}
