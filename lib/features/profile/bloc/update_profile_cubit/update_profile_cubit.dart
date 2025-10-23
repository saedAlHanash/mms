import 'dart:async';

import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/features/profile/data/request/update_profile_request.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../generated/l10n.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends MCubit<UpdateProfileInitial> {
  UpdateProfileCubit() : super(UpdateProfileInitial.initial());
  @override
  get mState => state;
  @override
  String get nameCache => 'updateProfile';

  Future<void> updateProfile() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));

    final pair = await _updateProfileApi();

    if (pair.first == null) {
      emit(state.copyWith(error: pair.second, statuses: CubitStatuses.error));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  void setValuesInitial() {}

  Future<Pair<bool?, String?>> _updateProfileApi() async {
    final response = await APIService().callApi(
      type: ApiType.put,
      url: PostUrl.updateProfile,
      body: state.request.toJson(),
      query: {'id': AppProvider.getParty.id},
    );

    if (response.statusCode.success) {
      return Pair(true, null);
    } else {
      return response.getPairError;
    }
  }

  set setFirstName(String? val) => state.request.firstName = val;

  set setLastName(String? val) => state.request.lastName = val;

  set setMiddleName(String? val) => state.request.middleName = val;

  set setGender(GenderEnum? gender) => state.request.gender = gender;

  set setAddress(String? val) => state.request.address = val;

  set setBirthday(DateTime? birthday) => state.request.dob = birthday;

  set setPhone(String? val) => state.request.phone = val;

  set setWorkPhone(String? val) => state.request.workPhone = val;

  set setEmail(String? val) => state.request.email = val;

  set setCompany(String? val) => state.request.company = val;

  set serPersonalPhoto(String? val) => state.request.personalPhoto = val;

  String? get validateName {
    if (state.request.firstName == null || state.request.lastName == null || state.request.middleName == null) {
      return S().nameEmpty;
    }
    return null;
  }

  String? get validateEmail {
    if (state.request.email == null) {
      return S().emailEmpty;
    }
    return null;
  }

  String? get validateLocation {
    if (state.request.address == null) {
      return '${S().location} ${S().is_required}';
    }
    return null;
  }

  String? get validateBirthday {
    // if (state.request.birthday == null) {
    //   return '${S().birthday} ${S().is_required}';
    // }
    return null;
  }

  String? get validatePhone {
    if (state.request.phone == null) {
      return '${S().email} - ${S().phoneNumber}'
          ' ${S().is_required}';
    }
    return null;
  }

  void setParty() {
    emit(
      state.copyWith(
        request: UpdatePartyRequest.fromJson(AppProvider.getParty.toJson()),
      ),
    );
  }
}
