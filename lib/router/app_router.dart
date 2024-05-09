import 'package:e_move/services/location_service/my_location_cubit/my_location_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/injection/injection_container.dart';
import '../features/auth/bloc/confirm_code_cubit/confirm_code_cubit.dart';
import '../features/auth/bloc/forget_password_cubit/forget_password_cubit.dart';
import '../features/auth/bloc/login_cubit/login_cubit.dart';
import '../features/auth/bloc/login_social_cubit/login_social_cubit.dart';
import '../features/auth/bloc/otp_password_cubit/otp_password_cubit.dart';
import '../features/auth/bloc/resend_code_cubit/resend_code_cubit.dart';
import '../features/auth/bloc/reset_password_cubit/reset_password_cubit.dart';
import '../features/auth/bloc/signup_cubit/signup_cubit.dart';
import '../features/auth/ui/pages/confirm_code_page.dart';
import '../features/auth/ui/pages/done_page.dart';
import '../features/auth/ui/pages/forget_passowrd_page.dart';
import '../features/auth/ui/pages/login_page.dart';
import '../features/auth/ui/pages/otp_password_page.dart';
import '../features/auth/ui/pages/reset_password_page.dart';
import '../features/auth/ui/pages/signup_page.dart';
import '../features/auth/ui/pages/splash_screen_page.dart';
import '../features/educational_grade/bloc/educational_grade_cubit/educational_grade_cubit.dart';

class AppRoutes {
  static Route<dynamic> routes(RouteSettings settings) {
    var screenName = settings.name;

    switch (screenName) {
      //region auth
      case RouteName.splash:
        //region
        return MaterialPageRoute(builder: (_) => const SplashScreenPage());
      //endregion
      case RouteName.signup:
        //region
        {
          return MaterialPageRoute(
            builder: (_) {
              final providers = [
                BlocProvider(create: (_) => sl<SignupCubit>()),
                BlocProvider(create: (_) => sl<LocationServiceCubit>()),
                BlocProvider(
                  create: (_) =>
                      sl<EducationalGradeCubit>()..getEducationalGrade(),
                ),
              ];
              return MultiBlocProvider(
                providers: providers,
                child: const SignupPage(),
              );
            },
          );
        }
      //endregion
      case RouteName.login:
        //region
        {
          final providers = [
            BlocProvider(create: (_) => sl<LoginCubit>()),
            BlocProvider(create: (_) => sl<LoginSocialCubit>()),
          ];
          return MaterialPageRoute(
            builder: (_) {
              return MultiBlocProvider(
                providers: providers,
                child: const LoginPage(),
              );
            },
          );
        }
      //endregion
      case RouteName.forgetPassword:
        //region
        {
          final providers = [
            BlocProvider(create: (_) => sl<ForgetPasswordCubit>()),
          ];
          final arg = settings.arguments;
          return MaterialPageRoute(
            builder: (_) {
              return MultiBlocProvider(
                providers: providers,
                child: ForgetPasswordPage(phone: arg is String ? arg : null),
              );
            },
          );
        }
      //endregion
      case RouteName.resetPasswordPage:
        //region
        {
          final providers = [
            BlocProvider(create: (_) => sl<ResetPasswordCubit>()),
          ];
          return MaterialPageRoute(
            builder: (_) {
              return MultiBlocProvider(
                providers: providers,
                child: const ResetPasswordPage(),
              );
            },
          );
        }
      //endregion
      case RouteName.confirmCode:
        //region
        {
          final providers = [
            BlocProvider(create: (_) => sl<ConfirmCodeCubit>()),
            BlocProvider(create: (_) => sl<ResendCodeCubit>()),
          ];
          return MaterialPageRoute(
            builder: (_) {
              return MultiBlocProvider(
                providers: providers,
                child: const ConfirmCodePage(),
              );
            },
          );
        }
      //endregion
      case RouteName.otpPassword:
        //region
        {
          final providers = [
            BlocProvider(create: (_) => sl<OtpPasswordCubit>()),
            BlocProvider(create: (_) => sl<ResendCodeCubit>()),
          ];
          return MaterialPageRoute(
            builder: (_) {
              return MultiBlocProvider(
                providers: providers,
                child: const OtpPasswordPage(),
              );
            },
          );
        }
      //endregion

      case RouteName.donePage:
        //region
        {
          return MaterialPageRoute(
            builder: (_) {
              return const DonePage();
            },
          );
        }
      //endregion
      //endregion

      //region home
      case RouteName.home:
      //region
        {
          return MaterialPageRoute(
            builder: (_) {
              return const DonePage();
            },
          );
        }
      //endregion

      //region settings

      //endregion

      //region orders and cart

      //endregion

      //region product

      //endregion

      //region product

      //endregion

      //region webView

      //endregion

      //region Chat

      //endregion
    }

    return MaterialPageRoute(
        builder: (_) => const Scaffold(backgroundColor: Colors.red));
  }
}

class RouteName {
  static const splash = '/';
  static const welcomeScreen = '/1';
  static const home = '/2';
  static const forgetPassword = '/3';
  static const resetPasswordPage = '/4';
  static const login = '/5';
  static const signup = '/6';
  static const confirmCode = '/7';
  static const otpPassword = '/9';
  static const donePage = '/10';
}
