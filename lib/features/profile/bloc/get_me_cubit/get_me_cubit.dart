import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../../members/data/response/member_response.dart';

part 'get_me_state.dart';

class GetMeCubit extends MCubit<GetMeInitial> {
    GetMeCubit() : super(GetMeInitial.initial());

  @override
  String get nameCache => 'profile';

  Future<void> getProfile({bool newData = false}) async {
    final cacheType = newData ? NeedUpdateEnum.noLoading : await needGetData();

    emit(
      state.copyWith(
        statuses: cacheType.getState,
        result: Party.fromJson(await getDataCached()),
      ),
    );

    if (cacheType == NeedUpdateEnum.no) return;

    final pair = await _getDataApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
      storeData(pair.first!);
    }
  }

  Future<Pair<Party?, String?>> _getDataApi() async {
    final response = await APIService().getApi(url: GetUrl.educationalGrade);

    if (response.statusCode.success) {
      return Pair(Party.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }
}
