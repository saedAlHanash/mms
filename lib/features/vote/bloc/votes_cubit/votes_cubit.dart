import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/api_manager/request_models/command.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/vote_response.dart';

part 'votes_state.dart';

class VotesCubit extends MCubit<VotesInitial> {
  VotesCubit() : super(VotesInitial.initial());

  @override
  String get nameCache => 'votes';

  @override
  String get filter => (state.filterRequest?.getKey) ?? state.request ?? '';

  Future<void> getVotes({bool newData = false}) async {

    final checkData = await checkCashed1(
        state: state, fromJson: Vote.fromJson, newData: newData);

    if (checkData) return;

    final pair = await _getVotes();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      await storeData(pair.first!);
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<Vote>?, String?>> _getVotes() async {
    final response = await APIService().callApi(
      type: ApiType.post,
      url: PostUrl.votes,
      body: state.filterRequest?.toJson() ?? {},
    );

    if (response.statusCode.success) {
      return Pair(Votes.fromJson(response.jsonBodyPure).items, null);
    } else {
      return response.getPairError;
    }
  }

  void setRequest(FilterRequest request) {
    emit(state.copyWith(filterRequest: request));
  }
}
