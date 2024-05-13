import 'package:flutter/material.dart';

import '../../features/auth/data/response/login_response.dart';
import '../../generated/l10n.dart';
import '../../router/app_router.dart';
import '../strings/enum_manager.dart';
import '../util/shared_preferences.dart';
import '../util/snack_bar_message.dart';
import 'app_widget.dart';

class AppProvider {
  final fcmToken = AppSharedPreference.getFireToken;

  LoginResponse get getMe => AppSharedPreference.getUser;

  static bool get isLogin => AppSharedPreference.getToken.isNotEmpty;

  static bool get isNotLogin => !isLogin;

  static bool get needLogin {
    if (isNotLogin) {
      if (ctx != null) {
        NoteMessage.showCheckDialog(
          ctx!,
          text: S.of(ctx!).needLogin,
          textButton: S.of(ctx!).login,
          image: Icons.login,
          onConfirm: () {
            Navigator.pushNamed(ctx!, RouteName.login);
          },
        );
      }
      return true;
    }
    return false;
  }

  static Future<void> login({required LoginResponse response}) async {
    await AppSharedPreference.cashToken(response.accessToken);
    await AppSharedPreference.cashUser(response);
  }

  static bool? get isSignupCashed {
    if (AppSharedPreference.getStartPage == StartPage.signupOtp) return true;
    if (AppSharedPreference.getStartPage == StartPage.passwordOtp) return false;
    return null;
  }

  static Future<void> logout() async {
    await AppSharedPreference.logout();
    if (ctx != null) {
      Navigator.pushNamedAndRemoveUntil(
          ctx!, RouteName.splash, (route) => false);
    }
  }

  static Future<void> cachePhone(
      {required String phone, required StartPage type}) async {
    await AppSharedPreference.cashPhone(phone);
    await AppSharedPreference.cashStartPage(type);
  }

  static String get getPhoneCached => AppSharedPreference.getPhone;
}

StartPage get getStartPage {
  if (AppProvider.isLogin) return StartPage.home;

  return AppSharedPreference.getStartPage;
}
