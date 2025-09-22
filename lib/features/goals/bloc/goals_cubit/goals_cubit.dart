import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import 'package:m_cubit/abstraction.dart';
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
    final pair = await _getData();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      await saveData(pair.first!);
      emit(state.copyWith(
        statuses: CubitStatuses.done,
        result: pair.first,
      ));
    }
  }

  Future<Pair<List<Goal>?, String?>> _getData() async {
    final response = await APIService().callApi(type: ApiType.get, url: GetUrl.goal);

    if (response.statusCode.success) {
      return Pair([], null);
    } else {
      return response.getPairError;
    }
  }

}
