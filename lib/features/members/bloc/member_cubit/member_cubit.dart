import 'package:m_cubit/abstraction.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/member_response.dart';

part 'member_state.dart';

class MemberCubit extends MCubit<MemberInitial> {
  MemberCubit() : super(MemberInitial.initial());

  @override
  String get nameCache => 'temp';

  Future<void> getMember() async {
    final pair = await _getData();
    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      await saveData(pair.first!);
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<Member?, String?>> _getData() async {
    final response = await APIService().callApi(type: ApiType.get, url: GetUrl.temp);

    if (response.statusCode.success) {
      return Pair(Member.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }
}
