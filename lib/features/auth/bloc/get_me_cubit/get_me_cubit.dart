import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/features/members/data/response/member_response.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';

part 'get_me_state.dart';

class LoggedPartyCubit extends MCubit<LoggedPartyInitial> {
  LoggedPartyCubit() : super(LoggedPartyInitial.initial());

  @override
  String get nameCache => 'loggedParty';

  Future<void> getLoggedParty() async {
    if (await checkCashed()) return;

    final pair = await _getDataApi();
    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {

      await storeData(pair.first!);

      await AppProvider.loggedParty(response: pair.first!);

      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<Party?, String?>> _getDataApi() async {
    final response = await APIService().getApi(url: GetUrl.loggedParty);

    if (response.statusCode.success) {
      return Pair(Party.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }

  Future<bool> checkCashed() async {
    final cacheType = await needGetData();

    emit(
      state.copyWith(
        statuses: cacheType.getState,
        result: Party.fromJson(await getDataCached()),
      ),
    );

    if (cacheType == NeedUpdateEnum.no) return true;
    return false;
  }
}
