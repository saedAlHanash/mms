import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../generated/l10n.dart';
import '../../data/request/add_guest_request.dart';

part 'add_guest_state.dart';

class AddGuestCubit extends Cubit<AddGuestInitial> {
  AddGuestCubit() : super(AddGuestInitial.initial());

  Future<void> getAddGuest() async {
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
      url: PostUrl.addGuest,
      body: state.request.toJson(),
    );

    if (response.statusCode.success) {
      return Pair(true, null);
    } else {
      return response.getPairError;
    }
  }

  set setFName(String? val) => state.request.firstName = val;

  set setLName(String? val) => state.request.lastName = val;

  set setCompany(String? val) => state.request.company = val;

  set setEmail(String? val) => state.request.email = val;

  set setPhone(String? val) => state.request.phone = val;

  String? get validateName {
    if (state.request.lastName.isBlank || state.request.lastName.isBlank) {
      return S().is_required;
    }
    return null;
  }

  String? get validateEmail {
    if (state.request.email.isBlank) {
      return S().is_required;
    }
    return null;
  }

  String? get validateCompany {
    if (state.request.company.isBlank) {
      return S().is_required;
    }
    return null;
  }

  String? get validatePhone {
    if (state.request.phone.isBlank) {
      return S().is_required;
    }
    return null;
  }
}
