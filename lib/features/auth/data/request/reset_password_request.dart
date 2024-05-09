import 'package:e_move/core/util/shared_preferences.dart';

import '../../../../core/app/app_provider.dart';

class ResetPasswordRequest {
  ResetPasswordRequest({
    this.password,
    this.passwordConfirmation,
  });

  String? password;
  String? passwordConfirmation;

  Map<String, dynamic> toJson() => {
        "phone": AppProvider.getPhoneCached,

        "password": password,
        "password_confirmation": passwordConfirmation,
      };
}
