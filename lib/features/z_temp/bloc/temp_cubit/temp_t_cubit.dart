import 'package:e_move/core/api_manager/api_url.dart';
import 'package:e_move/core/extensions/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/temp.dart';

part 'temp_t_state.dart';

class TempCubit extends Cubit<TempInitial> {
  TempCubit() : super(TempInitial.initial());

  Future<void> getTemp() async {
     

    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _bookedAppointmentsApi();
    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<TempModel?, String?>> _bookedAppointmentsApi() async {
    final response = await APIService().getApi(url: GetUrl.temp);

    if (response.statusCode.success) {
      return Pair(TempModel.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }
}
