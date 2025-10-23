import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordInitial> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial.initial());

  Future<void> forgetPassword() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _forgetPasswordApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      await AppProvider.cachePhone(phone: state.phoneC.text, type: StartPage.passwordOtp);
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _forgetPasswordApi() async {
    final response =
        await APIService().callApi(type: ApiType.post, url: PostUrl.forgetPassword, body: {'phone': state.phoneC.text});

    if (response.statusCode.success) {
      return Pair(true, null);
    } else {
      return response.getPairError;
    }
  }
}
