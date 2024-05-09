import 'package:e_move/services/firebase_service.dart';

class LoginRequest {
  String? phone;
  String? password;
  String? code;

  LoginRequest({
    this.phone,
    this.password,
    this.code,
  });

  LoginRequest copyWith({
    String? phone,
    String? password,
  }) {
    return LoginRequest(
      phone: phone ?? this.phone,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'password': password,
      'verification_code': code,
      'fcm_token': FirebaseService.getFireTokenFromCache,
    };
  }
}
