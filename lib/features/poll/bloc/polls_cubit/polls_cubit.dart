import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/api_manager/request_models/command.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/poll_response.dart';

part 'polls_state.dart';

class PollsCubit extends MCubit<PollsInitial> {
  PollsCubit() : super(PollsInitial.initial());

  @override
  String get nameCache => 'polls';

  @override
  String get filter => (state.filterRequest?.getKey) ?? state.request ?? '';

  Future<void> getPolls({bool newData = false}) async {
    await getDataAbstract(
      fromJson: Poll.fromJson,
      state: state,
      getDataApi: _getPolls,
      newData: newData,
    );
  }

  Future<Pair<List<Poll>?, String?>> _getPolls() async {
    final response = await APIService().callApi(
      type: ApiType.post,
      url: PostUrl.polls,
      body: state.filterRequest?.toJson() ?? {},
    );

    if (response.statusCode.success) {
      return Pair(Polls.fromJson(response.jsonBodyPure).items, null);
    } else {
      return response.getPairError;
    }
  }
}
