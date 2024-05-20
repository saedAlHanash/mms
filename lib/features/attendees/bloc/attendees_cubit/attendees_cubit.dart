import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/attendee_response.dart';


part 'attendees_state.dart';

class AttendeesCubit extends MCubit<AttendeesInitial> {
  AttendeesCubit() : super(AttendeesInitial.initial());

  @override
  String get nameCache => 'temp';

  @override
  String get id => '';

  @override
  String get by => '';

  Future<void> getAttendees() async {
    if (await checkCashed()) return;

    final pair = await _getDataApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      await storeData(pair.first!);
      emit(state.copyWith(
          statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<Attendee>?, String?>> _getDataApi() async {
    final response = await APIService().getApi(url: GetUrl.temp);

    if (response.statusCode.success) {
      return Pair([], null);
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
            (await getListCached()).map((e) => Attendee.fromJson(e)).toList(),
      ),
    );

    if (cacheType == NeedUpdateEnum.no) return true;
    return false;
  }
}
