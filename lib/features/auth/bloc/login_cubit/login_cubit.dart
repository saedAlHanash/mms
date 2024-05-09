import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_move/core/api_manager/api_url.dart';
import 'package:e_move/core/extensions/extensions.dart';
import 'package:e_move/core/util/shared_preferences.dart';
import 'package:e_move/features/auth/data/request/login_request.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/app/app_provider.dart';
import '../../../../core/app/app_widget.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../data/response/login_response.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginInitial> {
  LoginCubit() : super(LoginInitial.initial());

  Future<void> login() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _loginApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      await AppProvider.login(response: pair.first!);
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<LoginResponse?, String?>> _loginApi() async {
    final response = await APIService().postApi(
      url: PostUrl.loginUrl,
      body: state.request.toJson(),
    );

    if (response.statusCode.success) {
      final pair = Pair(LoginResponse.fromJson(response.jsonBody), null);

      return pair;
    } else {
      final error = response.getPairError as Pair<LoginResponse?, String?>;
      if (error.second?.contains('not verified') ?? false) {
        AppSharedPreference.cashPhone(state.request.phone);
        if (ctx != null) {
          Navigator.pushNamedAndRemoveUntil(
              ctx!, RouteName.confirmCode, (route) => false);
        }
      }
      return error;
    }
  }

  set setPhone(String? phone) => state.request.phone = phone;

  set setPassword(String? password) => state.request.password = password;

  String? get validatePhone {
    if (state.request.phone.isBlank) {
      return '${S().email} - ${S().phoneNumber}'
          ' ${S().is_required}';
    }
    return null;
  }

  String? get validatePassword {
    if (state.request.password.isBlank) {
      return '${S().password} ${S().is_required}';
    }
    return null;
  }
}
