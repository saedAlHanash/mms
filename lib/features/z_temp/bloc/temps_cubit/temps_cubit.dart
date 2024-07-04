import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/api_manager/request_models/command.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
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
    await getDataAbstract(
      fromJson: Temp.fromJson,
      state: state,
      getDataApi: _getTemps,
      newData: newData,
    );
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
}
