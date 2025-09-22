import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import 'package:m_cubit/abstraction.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/agendas_response.dart';

part 'agenda_state.dart';

class AgendaCubit extends MCubit<AgendaInitial> {
  AgendaCubit() : super(AgendaInitial.initial());

  @override
  String get nameCache => 'agenda';

  Future<void> getData({bool newData = false}) async {
    await getDataAbstract(
      fromJson: Agenda.fromJson,
      state: state,
      getDataApi: _getData,
      newData: newData,
    );
  }

  Future<Pair<Agenda?, String?>> _getData() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.agenda,
    );

    if (response.statusCode.success) {
      return Pair(Agenda.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }
}
