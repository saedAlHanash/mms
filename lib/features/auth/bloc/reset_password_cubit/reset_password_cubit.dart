import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';import 'package:m_cubit/abstraction.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../generated/l10n.dart';
import '../../data/request/reset_password_request.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordInitial> {
  ResetPasswordCubit() : super(ResetPasswordInitial.initial());

  Future<void> resetPassword() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));

    final pair = await _resetPasswordApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      AppSharedPreference.removePhone();
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _resetPasswordApi() async {
    final response = await APIService().callApi(type: ApiType.post,
      url: PostUrl.resetPassword,
      body: state.request.toJson(),
    );
    if (response.statusCode == 200) {
      final pair = Pair(true, null);
      return pair;
    } else {
        return response.getPairError;
    }
  }

  set setConfirmPassword(String? phone) =>
      state.request.passwordConfirmation = phone;

  set setPassword(String? password) => state.request.password = password;

  String? get validateConfirmPassword {
    if (state.request.passwordConfirmation.isBlank) {
      return S().passwordEmpty;
    }
    if (state.request.passwordConfirmation != state.request.password) {
      return S().passwordNotMatch;
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
