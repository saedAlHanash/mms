import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/request_models/command.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/temp.dart';

part 'temp_t_state.dart';

class TempCubit extends MCubit<TempInitial> {
  TempCubit() : super(TempInitial.initial());

  @override
  String get nameCache => 'temp';



  @override
  String get filter => '';

  Future<void> getTemp() async {
    if (await checkCashed()) return;

    final pair = await _getDataApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      await storeData(pair.first!);
      emit(state.copyWith(
          statuses: CubitStatuses.done, result: pair.first?.data));
    }
  }

  Future<Pair<TempList?, String?>> _getDataApi() async {
    final response = await APIService().getApi(url: GetUrl.temp);

    if (response.statusCode.success) {
      return Pair(TempList.fromJson(response.jsonBodyPure), null);
    } else {
      return response.getPairError;
    }
  }

  Future<bool> checkCashed() async {
    final cacheType = await needGetData();

    emit(
      state.copyWith(
        statuses: cacheType.getState,
        result:
            (await getListCached()).map((e) => TempModel.fromJson(e)).toList(),
      ),
    );

    if (cacheType == NeedUpdateEnum.no) return true;
    return false;
  }
}
