import 'package:bloc/bloc.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/util/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/api_manager/api_url.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../generated/l10n.dart';
import '../../data/request/login_request.dart';
import '../../data/response/login_response.dart';

part 'confirm_code_state.dart';

class ConfirmCodeCubit extends Cubit<ConfirmCodeInitial> {
  ConfirmCodeCubit() : super(ConfirmCodeInitial.initial());

  Future<void> confirmCode() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));

    final pair = await _confirmCodeApi();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<LoginResponse?, String?>> _confirmCodeApi() async {
    final response = await APIService().callApi(type: ApiType.post,
      url: PostUrl.confirmCode,
      body: state.request.toJson(),
    );

    if (response.statusCode == 200) {
      final pair = Pair(LoginResponse.fromJson(response.jsonBody), null);

      AppSharedPreference.cashToken(pair.first.accessToken);
      AppSharedPreference.removePhone();
      return pair;
    } else {
      return response.getPairError;
    }
  }

  set setPhone(String? phone) => state.request.userName = phone;

  set setCode(String? code) => state.request.programKey = code;

  String? get validatePhone {
    if (state.request.userName.isBlank) {
      return '${S().email} - ${S().phoneNumber}'
          ' ${S().is_required}';
    }
    return null;
  }

  String? get validateCode {
    if (state.request.programKey.isBlank) {
      return S().confirmCode;
    }
    return null;
  }
}
