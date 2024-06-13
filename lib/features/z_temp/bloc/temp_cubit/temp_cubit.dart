import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/temp_response.dart';

part 'temp_state.dart';

class TempCubit extends MCubit<TempInitial> {
  TempCubit() : super(TempInitial.initial());

  @override
  String get nameCache => 'temp';

  @override
  String get filter => state.request ?? '';

  Future<void> getTemp({bool newData = false, required String tempId}) async {
    emit(state.copyWith(request: tempId));
    final checkData = await checkCashed1(
        state: state, fromJson: Temp.fromJson, newData: newData);

    if (checkData) return;

    final pair = await _getTemp();
    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      await storeData(pair.first!);
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<Temp?, String?>> _getTemp() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.temp,
      query: {'Id': state.request},
    );

    if (response.statusCode.success) {
      return Pair(Temp.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }
}
