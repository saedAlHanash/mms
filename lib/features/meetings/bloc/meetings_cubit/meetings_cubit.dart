import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/request_models/command.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/meetings_response.dart';

part 'meetings_state.dart';

class MeetingsCubit extends MCubit<MeetingsInitial> {
  MeetingsCubit() : super(MeetingsInitial.initial());

  @override
  String get nameCache => 'meeting';

  @override
  String get id => '';

  @override
  String get by => state.filterRequest?.getKey ?? '';

  Future<void> getMeetings({FilterRequest? request}) async {

    emit(state.copyWith(filterRequest: request));

    if (await checkCashed()) return;

    final pair = await _getDataApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      await storeData(pair.first!);
      emit(state.copyWith(
        statuses: CubitStatuses.done,
        result: pair.first,
        events: _getMapEvent(pair.first!),
      ));
    }
  }

  Future<Pair<List<Meeting>?, String?>> _getDataApi() async {
    final response = await APIService().postApi(
      url: PostUrl.meetings,
      body: state.filterRequest?.toJson() ?? {},
    );

    if (response.statusCode.success) {
      return Pair(MeetingsResponse.fromJson(response.jsonBodyPure).items, null);
    } else {
      return response.getPairError;
    }
  }

  Future<bool> checkCashed() async {
    final cacheType = await needGetData();

    emit(
      state.copyWith(
        statuses: cacheType.getState,
        result:
            (await getListCached()).map((e) => Meeting.fromJson(e)).toList(),
      ),
    );

    if (cacheType == NeedUpdateEnum.no) return true;
    return false;
  }

  Map<int, List<Meeting>> _getMapEvent(List<Meeting> list) {
    var map = <int, List<Meeting>>{};

    for (var e in list) {
      var key = e.fromDate?.hashDate ?? 0;

      if (map[key] == null) {
        map[key] = [e];
      } else {
        map[key]?.add(e);
      }
    }
    return map;
  }
}
