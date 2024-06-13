import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/api_manager/request_models/command.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/temp_response.dart';

part 'temps_state.dart';

class TempsCubit extends MCubit<TempsInitial> {
  TempsCubit() : super(TempsInitial.initial());

  @override
  String get nameCache => 'temps';

  @override
  String get filter => (state.filterRequest?.getKey) ?? state.request ?? '';

  Future<void> getTemps({bool newData = false}) async {

    final checkData = await checkCashed1(
        state: state, fromJson: Temp.fromJson, newData: newData);

    if (checkData) return;

    final pair = await _getTemps();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      await storeData(pair.first!);
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<Temp>?, String?>> _getTemps() async {
    final response = await APIService().callApi(
      type: ApiType.post,
      url: PostUrl.temps,
      body: state.filterRequest?.toJson() ?? {},
    );

    if (response.statusCode.success) {
      return Pair(Temps.fromJson(response.jsonBodyPure).items, null);
    } else {
      return response.getPairError;
    }
  }

  void setRequest(FilterRequest request) {
    emit(state.copyWith(filterRequest: request));
  }
}
