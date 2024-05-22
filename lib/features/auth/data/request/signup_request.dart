import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/strings/enum_manager.dart';

import '../../../../generated/assets.dart';

class SignupRequest {
  SignupRequest({
    this.name,
    this.location,
    this.gender,
    this.locationName,
    this.birthday,
    this.phone,
    this.password,
    this.rePassword,
    this.educationalGradeId,
  });

  String? name;
  LatLng? location;
  GenderEnum? gender;
  String? locationName;
  DateTime? birthday;
  String? phone;
  String? password;
  String? rePassword;
  int? educationalGradeId;

  var identityImage =
      UploadFile(nameField: 'identity_image', assetImage: Assets.iconsIdentity);
  var profileImageUrl = UploadFile(
      nameField: 'profile_image_url', assetImage: Assets.iconsPicProfile);

  factory SignupRequest.fromJson(Map<String, dynamic> json) {
    return SignupRequest(
      name: json['first_name'] as String?,
      password: json['password'] as String?,
      locationName: json['locationName'] as String?,
      educationalGradeId: json['educational_grade_id'] as int?,
      rePassword: json['rePassword'] as String?,
      phone: json['phone'] as String?,
      gender: json['genderID'] == null
          ? null
          : GenderEnum.values[json['genderID'] ?? 0],
      birthday: DateTime.tryParse(json['birth_date'] ?? ''),
      location: (json['latitude'] == null || json['longitude'] == null)
          ? null
          : LatLng(json['latitude'] ?? 0, json['longitude'] ?? 0),
    );
  }

  Map<String, dynamic> toJson() => {
        'first_name': name,
        "password": password,
        "educational_grade_id": educationalGradeId,
        'rePassword': rePassword,
        'last_name': '.',
        'phone': phone,
        'gender': gender?.name,
        'genderID': gender?.index,
        'birth_date': birthday?.toIso8601String(),
        'latitude': location?.latitude,
        'longitude': location?.longitude,
        'locationName': locationName,
      };
}
