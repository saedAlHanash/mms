import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/enum_manager.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/util/pair_class.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutInitial> {
  LogoutCubit() : super(LogoutInitial.initial());

  Future<void> logout() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _logoutApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.done, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _logoutApi() async {
    final response = await APIService().callApi(
      type: ApiType.post,
      url: PostUrl.logout,
    );

    if (response.statusCode == 200) {
      return Pair(true, null);
    } else {
      return response.getPairError;
    }
  }
}
