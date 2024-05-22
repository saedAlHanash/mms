import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/agendas_response.dart';

part 'agenda_state.dart';

class AgendaCubit extends MCubit<AgendaInitial> {
  AgendaCubit() : super(AgendaInitial.initial());

  @override
  String get nameCache => 'agenda';

  Future<void> getAgenda() async {
    if (await checkCashed()) return;

    final pair = await _getDataApi();
    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      await storeData(pair.first!);
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<Agenda?, String?>> _getDataApi() async {
    final response = await APIService().getApi(url: GetUrl.agenda);

    if (response.statusCode.success) {
      return Pair(Agenda.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }

  Future<bool> checkCashed() async {
    final cacheType = await needGetData();

    emit(
      state.copyWith(
        statuses: cacheType.getState,
        result: Agenda.fromJson(await getDataCached()),
      ),
    );

    if (cacheType == NeedUpdateEnum.no) return true;
    return false;
  }
}
