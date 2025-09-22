import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';import 'package:m_cubit/abstraction.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/goals_response.dart';

part 'goal_state.dart';

class GoalCubit extends MCubit<GoalInitial> {
  GoalCubit() : super(GoalInitial.initial());

  @override
  String get nameCache => 'goal';

  Future<void> getGoal() async {


    final pair = await _getData();
    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      await saveData(pair.first!);
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<Goal?, String?>> _getData() async {
    final response = await APIService().callApi(type: ApiType.get,url: GetUrl.goal);

    if (response.statusCode.success) {
      return Pair(Goal.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }


}
