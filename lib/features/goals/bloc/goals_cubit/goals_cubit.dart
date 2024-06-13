import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/goals_response.dart';

part 'goals_state.dart';

class GoalsCubit extends MCubit<GoaslInitial> {
  GoalsCubit() : super(GoaslInitial.initial());

  @override
  String get nameCache => 'goal';



  @override
  String get filter => '';

  Future<void> getGoal() async {
    if (await checkCashed()) return;

    final pair = await _getDataApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      await storeData(pair.first!);
      emit(state.copyWith(
        statuses: CubitStatuses.done,
        result: pair.first,
      ));
    }
  }

  Future<Pair<List<Goal>?, String?>> _getDataApi() async {
    final response = await APIService().callApi(type: ApiType.get,url: GetUrl.goal);

    if (response.statusCode.success) {
      return Pair([], null);
    } else {
      return response.getPairError;
    }
  }

  Future<bool> checkCashed() async {
    final cacheType = await needGetData();

    emit(
      state.copyWith(
        statuses: cacheType.getState,
        result: (await getListCached()).map((e) => Goal.fromJson(e)).toList(),
      ),
    );

    if (cacheType == NeedUpdateEnum.no) return true;
    return false;
  }
}
