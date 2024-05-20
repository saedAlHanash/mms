import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/meetings_response.dart';

part 'meeting_state.dart';

class MeetingCubit extends MCubit<MeetingInitial> {
  MeetingCubit() : super(MeetingInitial.initial());

  @override
  String get nameCache => 'meeting';

  Future<void> getMeeting() async {
    if (await checkCashed()) return;

    final pair = await _getDataApi();
    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      await storeData(pair.first!);
      emit(
        state.copyWith(
          statuses: CubitStatuses.done,
          result: pair.first,

        ),
      );
    }
  }

  Future<Pair<Meeting?, String?>> _getDataApi() async {
    final response = await APIService().getApi(url: GetUrl.meeting);

    if (response.statusCode.success) {
      return Pair(Meeting.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }

  Future<bool> checkCashed() async {
    final cacheType = await needGetData();

    emit(
      state.copyWith(
        statuses: cacheType.getState,
        result: Meeting.fromJson(await getDataCached()),
      ),
    );

    if (cacheType == NeedUpdateEnum.no) return true;
    return false;
  }


}
