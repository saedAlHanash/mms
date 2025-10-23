import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/attendee_response.dart';

part 'attendees_state.dart';

class AttendeesCubit extends MCubit<AttendeesInitial> {
  AttendeesCubit() : super(AttendeesInitial.initial());
  @override
  get mState => state;
  @override
  String get nameCache => 'temp';

  @override
  String get filter => '';

  Future<void> getAttendees() async {
    final pair = await _getData();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      await saveData(pair.first!);
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<List<Attendee>?, String?>> _getData() async {
    final response = await APIService().callApi(type: ApiType.get, url: GetUrl.temp);

    if (response.statusCode.success) {
      return Pair([], null);
    } else {
      return response.getPairError;
    }
  }
}
