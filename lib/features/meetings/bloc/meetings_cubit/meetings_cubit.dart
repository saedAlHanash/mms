import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/features/committees/bloc/my_committees_cubit/my_committees_cubit.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/request_models/command.dart';
import '../../../../core/app/app_widget.dart';
import '../../../../core/strings/enum_manager.dart';
import 'package:m_cubit/abstraction.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/meetings_response.dart';

part 'meetings_state.dart';

class MeetingsCubit extends MCubit<MeetingsInitial> {
  MeetingsCubit() : super(MeetingsInitial.initial());

  @override
  String get nameCache => 'meeting';

  @override
  String get filter => state.filter.getKey ?? '';

  void setFilterRequest(FilterRequest? request) {
    emit(state.copyWith(filterRequest: request));
  }

  Future<void> getData({bool? newData}) async {
    getDataAbstract(
      fromJson: Meeting.fromJson,
      state: state,
      newData: newData,
      getDataApi: _getData,
      onSuccess: (data, emitState) async {
        emit(state.copyWith(
          statuses: emitState,
          result: data,
          events: _getMapEvent(data),
        ));
      },
    );
  }

  Future<Pair<List<Meeting>?, String?>> _getData() async {
    final response = await APIService().callApi(
      type: ApiType.post,
      url: PostUrl.meetings,
      body: (state.filterRequest?.toJson() ?? {})
        ..addAll(
          {
            "partyId": state.filterRequest?.filters['partyId']?.val,
          },
        ),
    );

    if (response.statusCode.success) {
      final list = MeetingsResponse.fromJson(response.jsonBodyPure).items;
      list.removeWhere((e) => !(ctx!.read<MyCommitteesCubit>().haveCommittee(e.committeeId)));
      return Pair(list, null);
    } else {
      return response.getPairError;
    }
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
