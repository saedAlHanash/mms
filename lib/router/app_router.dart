import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mms/core/api_manager/request_models/command.dart';
import 'package:mms/features/agendas/data/response/agendas_response.dart';
import 'package:mms/features/meetings/bloc/add_guest_cubit/add_guest_cubit.dart';
import 'package:mms/features/meetings/bloc/meeting_cubit/meeting_cubit.dart';
import 'package:mms/features/meetings/ui/pages/add_guest_page.dart';
import 'package:mms/features/meetings/ui/pages/calender_screen.dart';

import '../core/injection/injection_container.dart';
import '../features/agendas/bloc/add_comment_cubit/add_comment_cubit.dart';
import '../features/agendas/ui/pages/agenda_page.dart';
import '../features/auth/bloc/confirm_code_cubit/confirm_code_cubit.dart';
import '../features/auth/bloc/forget_password_cubit/forget_password_cubit.dart';
import '../features/auth/bloc/login_cubit/login_cubit.dart';
import '../features/auth/bloc/login_social_cubit/login_social_cubit.dart';
import '../features/auth/bloc/otp_password_cubit/otp_password_cubit.dart';
import '../features/auth/bloc/resend_code_cubit/resend_code_cubit.dart';
import '../features/auth/bloc/reset_password_cubit/reset_password_cubit.dart';
import '../features/auth/ui/pages/confirm_code_page.dart';
import '../features/auth/ui/pages/done_page.dart';
import '../features/auth/ui/pages/forget_passowrd_page.dart';
import '../features/auth/ui/pages/login_page.dart';
import '../features/auth/ui/pages/otp_password_page.dart';
import '../features/auth/ui/pages/reset_password_page.dart';
import '../features/auth/ui/pages/splash_screen_page.dart';
import '../features/committees/bloc/committee_cubit/committee_cubit.dart';
import '../features/committees/ui/pages/committee_page.dart';
import '../features/files/bloc/upload_file_cubit/upload_file_cubit.dart';
import '../features/home/ui/pages/home_page.dart';
import '../features/meetings/bloc/add_absence_cubit/add_absence_cubit.dart';
import '../features/meetings/bloc/meetings_cubit/meetings_cubit.dart';
import '../features/meetings/ui/pages/meeting_page.dart';
import '../features/notification/ui/pages/notifications_page.dart';
import '../features/profile/bloc/update_profile_cubit/update_profile_cubit.dart';
import '../features/profile/ui/pages/profile_page.dart';
import '../features/vote/bloc/create_vote_cubit/create_vote_cubit.dart';
import '../features/vote/ui/pages/votes_page.dart';

Route<dynamic> routes(RouteSettings settings) {
  var screenName = settings.name;

  switch (screenName) {
    //region auth
    case RouteName.splash:
      //region
      return MaterialPageRoute(builder: (_) => const SplashScreenPage());
    //endregion
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
            return const HomePage();
          },
        );
      }
    //endregion
    //endregion home

    //region settings
    case RouteName.profile:
      //region
      {
        return MaterialPageRoute(
          builder: (_) {
            final providers = [
              BlocProvider(create: (_) => sl<UpdateProfileCubit>()),
              BlocProvider(create: (_) => sl<FileCubit>()),
            ];
            return MultiBlocProvider(
              providers: providers,
              child: const ProfilePage(),
            );
          },
        );
      }
    //endregion

    //endregion

    //region orders and cart

    //endregion

    //region committee
    case RouteName.committeePage:
      //region
      {
        final uuid = settings.arguments as String;

        final providers = [
          BlocProvider(
              create: (context) =>
                  sl<CommitteeCubit>()..getCommittee(uuid: uuid)),
        ];
        return MaterialPageRoute(
          builder: (_) {
            return MultiBlocProvider(
              providers: providers,
              child: const CommitteePage(),
            );
          },
        );
      }
    //endregion
    //endregion

    //region meeting
    case RouteName.meeting:
      //region
      {
        final uuid = settings.arguments as String;

        final providers = [
          BlocProvider(
            create: (context) => sl<MeetingCubit>()..getMeeting(id: uuid),
          ),
          BlocProvider(create: (context) => sl<AddAbsenceCubit>()),
          BlocProvider(create: (context) => sl<AddCommentCubit>()),
        ];
        return MaterialPageRoute(
          builder: (_) {
            return MultiBlocProvider(
              providers: providers,
              child: const MeetingPage(),
            );
          },
        );
      }
    //endregion

    case RouteName.calenderMeetings:
      //region
      {
        final request = settings.arguments as FilterRequest;

        final providers = [
          BlocProvider(
              create: (context) =>
                  sl<MeetingsCubit>()..getMeetings(request: request)),
        ];
        return MaterialPageRoute(
          builder: (_) {
            return MultiBlocProvider(
              providers: providers,
              child: const CalenderMeetingPage(),
            );
          },
        );
      }
    //endregion

    case RouteName.addGuest:
      //region
      {
        final providers = [
          BlocProvider(create: (context) => sl<AddGuestCubit>()),
        ];
        return MaterialPageRoute(
          builder: (_) {
            return MultiBlocProvider(
              providers: providers,
              child: const AddGuestPage(),
            );
          },
        );
      }
    //endregion
    //endregion

    //region agenda
    case RouteName.agenda:
      //region
      {
        final providers = [
          BlocProvider(create: (context) => sl<AddCommentCubit>()),
          BlocProvider.value(
            value: (settings.arguments as List)[1] as MeetingCubit,
          ),
        ];
        return MaterialPageRoute(
          builder: (_) {
            return MultiBlocProvider(
              providers: providers,
              child:
                  AgendaPage(agenda: (settings.arguments as List)[0] as Agenda),
            );
          },
        );
      }
    //endregion
    //endregion

    //region votes
    case RouteName.votes:
      //region
      {
        final providers = [
          BlocProvider(create: (context) => sl<CreateVoteCubit>()),
          BlocProvider.value(
            value: (settings.arguments as MeetingCubit),
          ),
        ];
        return MaterialPageRoute(
          builder: (_) {
            return MultiBlocProvider(
              providers: providers,
              child: const VotesPage(),
            );
          },
        );
      }
    //endregion
    //endregion

    //region Chat

    //endregion

    //region notifications

    case RouteName.notifications:
      //region
      {
        return MaterialPageRoute(
          builder: (_) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => sl<FileCubit>()),
              ],
              child: const NotificationsPage(),
            );
          },
        );
      }
    //endregion

    //endregion
  }

  return MaterialPageRoute(
      builder: (_) => const Scaffold(backgroundColor: Colors.red));
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
  static const committeePage = '/11';
  static const profile = '/12';
  static const meeting = '/13';
  static const calenderMeetings = '/14';
  static const addGuest = '/15';
  static const agenda = '/16';
  static const votes = '/17';
  static const notifications = '/18';
}
