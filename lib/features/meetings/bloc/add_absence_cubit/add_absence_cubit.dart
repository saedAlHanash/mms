import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/app/app_provider.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../generated/l10n.dart';

part 'add_absence_state.dart';

class AddAbsenceCubit extends Cubit<AddAbsenceInitial> {
  AddAbsenceCubit() : super(AddAbsenceInitial.initial());

  Future<void> addAbsence() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));

    final pair = await _getDataApi();
    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _getDataApi() async {
    final response = await APIService().postApi(
      url: PostUrl.addAbsence,
      body: {
        "partyId": AppProvider.getParty.id,
        "meetingId": AppProvider.getCurrentMeeting.id,
      },
    );

    if (response.statusCode.success) {
      return Pair(true, null);
    } else {
      return response.getPairError;
    }
  }
}
