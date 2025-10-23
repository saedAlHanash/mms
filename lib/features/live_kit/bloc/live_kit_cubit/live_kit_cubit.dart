import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/core/util/pair_class.dart';
import 'package:mms/features/live_kit/data/response/live_kit_response.dart';

part 'live_kit_state.dart';

class LiveKitCubit extends MCubit<LiveKitInitial> {
  LiveKitCubit() : super(LiveKitInitial.initial());
  @override
  get mState => state;
  @override
  String get nameCache => 'liveKit';

  @override
  String get filter => state.filter;

  Future<void> getData({bool newData = false, String? liveKitId}) async {
    emit(state.copyWith(request: liveKitId));

    await getDataAbstract(
      fromJson: LiveKit.fromJson,
      state: state,
      getDataApi: _getData,
      newData: newData,
    );
  }

  Future<Pair<LiveKit?, String?>> _getData() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.liveKit,
      query: {'Id': state.request},
    );

    if (response.statusCode.success) {
      return Pair(LiveKit.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }

  void setLiveKit(dynamic liveKit) {
    if (liveKit is! LiveKit) return;

    emit(state.copyWith(result: liveKit));
  }
}
