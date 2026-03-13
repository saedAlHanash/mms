import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/vote_response.dart';

part 'vote_state.dart';

class VoteCubit extends MCubit<VoteInitial> {
  VoteCubit() : super(VoteInitial.initial());
  @override
  get mState => state;
  @override
  String get nameCache => 'vote';

  @override
  String get filter => state.request ?? '';

  Future<void> getVote({bool newData = false, required String voteId}) async {
    emit(state.copyWith(request: voteId));

    getDataAbstract(
      fromJson: Vote.fromJson,
      state: state,
      getDataApi: _getVote,
    );
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
