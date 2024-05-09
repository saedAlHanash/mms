import 'package:e_move/core/extensions/extensions.dart';

import 'package:e_move/core/extensions/extensions.dart';

class LoginResponse {
  LoginResponse({
    required this.user,
    required this.token,
  });

  final UserModel user;
  final String token;

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      user: UserModel.fromJson(json["user"] ?? {}),
      token: json["token"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "token": token,
      };
}

class UserModel {
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.fcmToken,
    required this.profileImageUrl,
    required this.identityImage,
    required this.latitude,
    required this.longitude,
    required this.gender,
    required this.educationalGrade,
  });

  final int id;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String fcmToken;
  final String profileImageUrl;
  final String identityImage;
  final num latitude;
  final num longitude;
  final String gender;
  final EducationalGrade? educationalGrade;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"].toString().tryParseOrZeroInt,
      firstName: json["first_name"] ?? "",
      lastName: json["last_name"] ?? "",
      phone: json["phone"] ?? "",
      email: json["email"] ?? "",
      fcmToken: json["fcm_token"] ?? "",
      profileImageUrl: json["profile_image_url"] ?? "",
      identityImage: json["identity_image"] ?? "",
      latitude: json["latitude"].toString().tryParseOrZero,
      longitude: json["longitude"].toString().tryParseOrZero,
      gender: json["gender"] ?? "",
      educationalGrade: json["educational_grade"] == null
          ? null
          : EducationalGrade.fromJson(json["educational_grade"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "email": email,
        "fcm_token": fcmToken,
        "profile_image_url": profileImageUrl,
        "identity_image": identityImage,
        "latitude": latitude,
        "longitude": longitude,
        "gender": gender,
        "educational_grade": educationalGrade?.toJson(),
      };
}

class EducationalGrade {
  EducationalGrade({
    required this.id,
    required this.name,
    required this.photo,
  });

  final int id;
  final String name;
  final String photo;

  factory EducationalGrade.fromJson(Map<String, dynamic> json) {
    return EducationalGrade(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      photo: json["photo"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photo": photo,
      };
}
