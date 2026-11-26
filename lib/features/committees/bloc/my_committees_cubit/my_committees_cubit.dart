import 'package:collection/collection.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';

import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/core/util/pair_class.dart';
import 'package:mms/features/committees/data/response/committees_response.dart';

part 'my_committees_state.dart';

class MyCommitteesCubit extends MCubit<MyCommitteesInitial> {
  MyCommitteesCubit() : super(MyCommitteesInitial.initial());
  @override
  get mState => state;
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
      // Every role sees the committee; screens show what the role may do.
      list.removeWhere((e) => e.member.membershipType == MembershipType.guest);
      return Pair(list, null);
    } else {
      return response.getPairError;
    }
  }

  bool haveCommittee(String id) {
    return state.result.firstWhereOrNull((e) => e.id == id) != null;
  }
}
