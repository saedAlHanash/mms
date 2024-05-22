import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/agendas_response.dart';

part 'agendas_state.dart';

class AgendasCubit extends MCubit<GoaslInitial> {
  AgendasCubit() : super(GoaslInitial.initial());

  @override
  String get nameCache => 'agenda';

  
  @override
  String get filter => '';

  Future<void> getAgenda() async {
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

  Future<Pair<List<Agenda>?, String?>> _getDataApi() async {
    final response = await APIService().getApi(url: GetUrl.agendas);

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
        result: (await getListCached()).map((e) => Agenda.fromJson(e)).toList(),
      ),
    );

    if (cacheType == NeedUpdateEnum.no) return true;
    return false;
  }
}
