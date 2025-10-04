import 'package:collection/collection.dart';
import 'package:m_cubit/abstraction.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/committees_response.dart';

part 'my_committees_state.dart';

class MyCommitteesCubit extends MCubit<MyCommitteesInitial> {
  MyCommitteesCubit() : super(MyCommitteesInitial.initial());

  @override
  String get nameCache => 'myCommittees';

  @override
  String get filter => '';

  Future<void> getData({bool? newData}) async {
    await getDataAbstract(
      fromJson: Committee.fromJson,
      state: state,
      getDataApi: _getData,
      newData: newData,
    );
  }

  Future<Pair<List<Committee>?, String?>> _getData() async {
    final response = await APIService().callApi(type: ApiType.get, url: GetUrl.myCommittees);

    if (response.statusCode.success) {
      final list = CommitteesResponse.fromJson(response.jsonBody).data;
      list.removeWhere((e) => !e.member.membershipType.isMember);
      return Pair(list, null);
    } else {
      return response.getPairError;
    }
  }

  bool haveCommittee(String id) {
    return state.result.firstWhereOrNull((e) => e.id == id) != null;
  }
}
