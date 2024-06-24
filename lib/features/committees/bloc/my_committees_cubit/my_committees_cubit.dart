import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/committees_response.dart';

part 'my_committees_state.dart';

class MyCommitteesCubit extends MCubit<MyCommitteesInitial> {
  MyCommitteesCubit() : super(MyCommitteesInitial.initial());

  @override
  String get nameCache => 'myCommittees';

  @override
  String get filter => '';

  Future<void> getMyCommittees({bool? newData}) async {
    await getDataAbstract(
      fromJson: Committee.fromJson,
      state: state,
      getDataApi: _getDataApi,
      newData: newData,
    );
  }

  Future<Pair<List<Committee>?, String?>> _getDataApi() async {
    final response =
        await APIService().callApi(type: ApiType.get, url: GetUrl.myCommittees);

    if (response.statusCode.success) {
      return Pair(CommitteesResponse.fromJson(response.jsonBody).data, null);
    } else {
      return response.getPairError;
    }
  }
}
