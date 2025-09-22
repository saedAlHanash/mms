import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:m_cubit/abstraction.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/features/goals/data/response/goals_response.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/committees_response.dart';

part 'committee_state.dart';

class CommitteeCubit extends MCubit<CommitteeInitial> {
  CommitteeCubit() : super(CommitteeInitial.initial());

  @override
  String get nameCache => 'committee';

  @override
  String get filter => state.uuid;

  Future<void> getData({String? uuid, bool? newData}) async {
    emit(state.copyWith(uuid: uuid));

    getDataAbstract(
      fromJson: Committee.fromJson,
      state: state,
      getDataApi: _getData,
      newData: newData,
    );
  }

  Future<Pair<Committee?, String?>> _getData() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.committee,
      query: {'id': state.uuid},
    );

    if (response.statusCode.success) {
      return Pair(Committee.fromJson(response.jsonBodyPure), null);
    } else {
      return response.getPairError;
    }
  }
}
