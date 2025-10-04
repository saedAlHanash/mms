import 'package:m_cubit/abstraction.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/poll_response.dart';

part 'poll_state.dart';

class PollCubit extends MCubit<PollInitial> {
  PollCubit() : super(PollInitial.initial());

  @override
  String get nameCache => 'poll';

  @override
  String get filter => state.request ?? '';

  Future<void> getPoll({bool newData = false, required String pollId}) async {
    emit(state.copyWith(request: pollId));

    await getDataAbstract(
      fromJson: Poll.fromJson,
      state: state,
      getDataApi: _getPoll,
      newData: newData,
    );
  }

  Future<Pair<Poll?, String?>> _getPoll() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.poll,
      query: {'Id': state.request},
    );

    if (response.statusCode.success) {
      return Pair(Poll.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }
}
