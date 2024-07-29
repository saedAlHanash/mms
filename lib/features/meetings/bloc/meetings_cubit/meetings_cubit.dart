import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/features/committees/bloc/my_committees_cubit/my_committees_cubit.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/request_models/command.dart';
import '../../../../core/app/app_widget.dart';
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
  String get filter => state.filterRequest?.getKey ?? '';

  Future<void> getMeetings({FilterRequest? request, bool? newData}) async {
    emit(state.copyWith(filterRequest: request));

    getDataAbstract(
      fromJson: Meeting.fromJson,
      state: state,
      newData: newData,
      getDataApi: _getDataApi,
      onGetFromCache: (emitState, data) {
        emit(
          state.copyWith(
            statuses: emitState,
            result: data,
            events: _getMapEvent(data),
          ),
        );
      },
      onSuccess: () async {
        Future(() => emit(state.copyWith(events: _getMapEvent(state.result))));
      },
    );
  }

  Future<Pair<List<Meeting>?, String?>> _getDataApi() async {
    final response = await APIService().callApi(
      type: ApiType.post,
      url: PostUrl.meetings,
      body: state.filterRequest?.toJson() ?? {},
    );

    if (response.statusCode.success) {
      final list = MeetingsResponse.fromJson(response.jsonBodyPure).items;
      list.removeWhere((e) =>
          !(ctx!.read<MyCommitteesCubit>().haveCommittee(e.committeeId)));
      return Pair(list, null);
    } else {
      return response.getPairError;
    }
  }

  Future<bool> checkCashed() async {
    final cacheType = await needGetData();
    final list =
        (await getListCached()).map((e) => Meeting.fromJson(e)).toList();
    emit(
      state.copyWith(
        statuses: cacheType.getState,
        events: _getMapEvent(list),
        result: list,
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
