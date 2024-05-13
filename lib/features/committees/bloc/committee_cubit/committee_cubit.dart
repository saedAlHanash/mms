import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
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
  String get id => state.uuid;

  @override
  String get by => '';

  Future<void> getCommittee({required String uuid}) async {
    emit(state.copyWith(uuid: uuid));

    if (await checkCashed()) return;

    final pair = await _getDataApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      await storeData(pair.first!);
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<Committee?, String?>> _getDataApi() async {
    final response = await APIService().getApi(
      url: GetUrl.committee,
      query: {'id': state.uuid},
    );

    if (response.statusCode.success) {
      return Pair(Committee.fromJson(response.jsonBodyPure), null);
    } else {
      return response.getPairError;
    }
  }

  Future<bool> checkCashed() async {
    final cacheType = await needGetData();

    emit(
      state.copyWith(
        statuses: cacheType.getState,
        result: Committee.fromJson(await getDataCached()),
      ),
    );

    if (cacheType == NeedUpdateEnum.no) return true;
    return false;
  }
}
