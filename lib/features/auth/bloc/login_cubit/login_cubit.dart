import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/util/shared_preferences.dart';
import 'package:mms/features/auth/data/request/login_request.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/app/app_provider.dart';
import '../../../../core/app/app_widget.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../../members/data/response/member_response.dart';
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
      final p = await _getDataApi();
      if (p.first != null) {
        await AppProvider.loggedParty(response: p.first!);
      }
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<LoginResponse?, String?>> _loginApi() async {
    final response = await APIService().callApi(type: ApiType.post,
      url: PostUrl.loginUrl,
      body: state.request.toJson(),
    );

    if (response.statusCode.success) {
      final pair = Pair(LoginResponse.fromJson(response.jsonBody), null);

      return pair;
    } else {
      final error = response.getPairError as Pair<LoginResponse?, String?>;
      if (error.second?.contains('not verified') ?? false) {
        AppSharedPreference.cashPhone(state.request.userName);
        if (ctx != null) {
          Navigator.pushNamedAndRemoveUntil(
              ctx!, RouteName.confirmCode, (route) => false);
        }
      }
      return error;
    }
  }

  Future<Pair<Party?, String?>> _getDataApi() async {
    final response = await APIService().callApi(type: ApiType.get,url: GetUrl.loggedParty);

    if (response.statusCode.success) {
      return Pair(Party.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }

  set setUserName(String? phone) => state.request.userName = phone;

  set setPassword(String? password) => state.request.password = password;

  String? get validateUserName {
    if (state.request.userName.isBlank) {
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
