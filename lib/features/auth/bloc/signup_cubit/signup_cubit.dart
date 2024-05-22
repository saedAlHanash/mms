import 'dart:typed_data';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../generated/l10n.dart';
import '../../../../services/caching_service/caching_service.dart';
import '../../data/request/signup_request.dart';

part 'signup_state.dart';

class SignupCubit extends MCubit<SignupInitial> {
  SignupCubit() : super(SignupInitial.initial()) {
    CachingService.getData(nameCache).then((value) {
      if (value == null) return;
      emit(state.copyWith(request: SignupRequest.fromJson(value)));
    });
  }

  @override
  String get nameCache => 'signup';

  Future<void> signup() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));

    await storeData(state.request.toJson());

    final pair = await _signupApi();

    if (pair.first == null) {
      emit(state.copyWith(error: pair.second, statuses: CubitStatuses.error));
      showErrorFromApi(state);
    } else {
      await AppProvider.cachePhone(
        phone: state.request.phone!,
        type: StartPage.signupOtp,
      );
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<bool?, String?>> _signupApi() async {
    final response = await APIService().uploadMultiPart(
      url: PostUrl.signup,
      fields: state.request.toJson(),
      files: [
        state.request.identityImage,
        state.request.profileImageUrl,
      ],
    );

    if (response.statusCode.success) {
      return Pair(true, null);
    } else {
      return response.getPairError;
    }
  }

  set setName(String? name) => state.request.name = name;

  set setGender(GenderEnum? gender) => state.request.gender = gender;

  set setEducationalGrade(int? id) => state.request.educationalGradeId = id;

  void setLocation({LatLng? location, String? locationName}) {
    state.request.location = location;
    state.request.locationName = locationName;
  }

  set setIdentityImage(Uint8List bytes) {
    state.request.identityImage.fileBytes = bytes;
  }

  set setProfileImage(Uint8List bytes) {
    state.request.profileImageUrl.fileBytes = bytes;
  }

  set setBirthday(DateTime? birthday) => state.request.birthday = birthday;

  set setPhone(String? phone) => state.request.phone = phone;

  set setPassword(String? password) => state.request.password = password;

  set setRePassword(String? rePassword) =>
      state.request.rePassword = rePassword;

  String? get validateName {
    if (state.request.name == null) {
      return S().nameEmpty;
    }
    return null;
  }

  String? get validateLocation {
    if (state.request.location == null) {
      return '${S().location} ${S().is_required}';
    }
    return null;
  }

  String? get validateBirthday {
    if (state.request.birthday == null) {
      return '${S().birthday} ${S().is_required}';
    }
    return null;
  }

  String? get validatePhone {
    if (state.request.phone == null) {
      return '${S().email} - ${S().phoneNumber}'
          ' ${S().is_required}';
    }
    return null;
  }

  String? get validatePassword {
    if (state.request.password == null) {
      return '${S().password} ${S().is_required}';
    }
    return null;
  }

  String? get validateRePassword {
    if (state.request.rePassword != state.request.password) {
      return S().passwordNotMatch;
    }
    return null;
  }
}
