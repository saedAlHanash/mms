import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/enum_manager.dart';import 'package:m_cubit/abstraction.dart';
import 'package:mms/core/util/pair_class.dart';
import 'package:mms/features/agora/data/response/agora_response.dart';
import 'package:m_cubit/abstraction.dart';

part 'agora_state.dart';

class AgoraCubit extends MCubit<AgoraInitial> {
  AgoraCubit() : super(AgoraInitial.initial());

  @override
  String get nameCache => 'agora';

  @override
  String get filter => state.filter;

  Future<void> getData({bool newData = false,  String? agoraId}) async {
    emit(state.copyWith(request: agoraId));

    await getDataAbstract(
      fromJson: Agora.fromJson,
      state: state,
      getDataApi: _getData,
      newData: newData,
    );
  }

  Future<Pair<Agora?, String?>> _getData() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.agora,
      query: {'Id': state.request},
    );

    if (response.statusCode.success) {
      return Pair(Agora.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }

  void setAgora(dynamic agora) {
    if (agora is! Agora) return;

    emit(state.copyWith(result: agora));
  }
}
 