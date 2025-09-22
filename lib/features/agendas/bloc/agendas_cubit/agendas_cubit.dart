import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import 'package:m_cubit/abstraction.dart';
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

  Future<void> getData({bool newData = false}) async {
    await getDataAbstract(
      fromJson: Agenda.fromJson,
      state: state,
      getDataApi: _getData,
      newData: newData,
    );
  }

  Future<Pair<List<Agenda>?, String?>> _getData() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.agendas,
    );

    if (response.statusCode.success) {
      return Pair([], null);
    } else {
      return response.getPairError;
    }
  }
}
