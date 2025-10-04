import 'package:m_cubit/abstraction.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/features/members/data/response/member_response.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';

part 'get_me_state.dart';

class LoggedPartyCubit extends MCubit<LoggedPartyInitial> {
  LoggedPartyCubit() : super(LoggedPartyInitial.initial());

  @override
  String get nameCache => 'loggedParty';

  Future<void> getData({bool? newData}) async {
    getDataAbstract(
      fromJson: Party.fromJson,
      state: state,
      getDataApi: _getData,
      newData: newData,
      onSuccess: (data, emitState) {
        emit(state.copyWith(result: data, statuses: emitState));
        Future(() => AppProvider.loggedParty(response: state.result));
      },
    );
  }

  Future<Pair<Party?, String?>> _getData() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.loggedParty,
    );

    if (response.statusCode.success) {
      return Pair(Party.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }
}
