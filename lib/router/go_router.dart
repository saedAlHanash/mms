import 'package:mms/features/delegation/bloc/delegations_cubit/delegations_cubit.dart';
import 'package:mms/features/quorum/bloc/quorum_cubit/quorum_cubit.dart';
import 'package:mms/features/check_in/bloc/check_in_code_cubit/check_in_code_cubit.dart';
import 'package:mms/features/check_in/ui/pages/check_in_code_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/injection/injection_container.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/features/agendas/bloc/add_comment_cubit/add_comment_cubit.dart';
import 'package:mms/features/agendas/data/response/agendas_response.dart';
import 'package:mms/features/agendas/ui/pages/agenda_page.dart';
import 'package:mms/features/auth/bloc/confirm_code_cubit/confirm_code_cubit.dart';
import 'package:mms/features/auth/bloc/forget_password_cubit/forget_password_cubit.dart';
import 'package:mms/features/auth/bloc/login_cubit/login_cubit.dart';
import 'package:mms/features/auth/bloc/login_social_cubit/login_social_cubit.dart';
import 'package:mms/features/auth/bloc/otp_password_cubit/otp_password_cubit.dart';
import 'package:mms/features/auth/bloc/resend_code_cubit/resend_code_cubit.dart';
import 'package:mms/features/auth/bloc/reset_password_cubit/reset_password_cubit.dart';
import 'package:mms/features/auth/ui/pages/confirm_code_page.dart';
import 'package:mms/features/auth/ui/pages/done_page.dart';
import 'package:mms/features/auth/ui/pages/forget_passowrd_page.dart';
import 'package:mms/features/auth/ui/pages/login_page.dart';
import 'package:mms/features/auth/ui/pages/otp_password_page.dart';
import 'package:mms/features/auth/ui/pages/reset_password_page.dart';
import 'package:mms/features/auth/ui/pages/splash_screen_page.dart';
import 'package:mms/features/check_in/bloc/check_in_cubit/check_in_cubit.dart';
import 'package:mms/features/check_in/ui/pages/check_in_page.dart';
import 'package:mms/features/committees/bloc/committee_cubit/committee_cubit.dart';
import 'package:mms/features/committees/ui/pages/committee_page.dart';
import 'package:mms/features/files/bloc/upload_file_cubit/upload_file_cubit.dart';
import 'package:mms/features/home/ui/pages/home_page.dart';
import 'package:mms/features/meeting_hub/bloc/meeting_hub_cubit/meeting_hub_cubit.dart';
import 'package:mms/features/agenda_request/bloc/my_agenda_requests_cubit/my_agenda_requests_cubit.dart';
import 'package:mms/features/circulation/bloc/circulation_cubit/circulation_cubit.dart';
import 'package:mms/features/circulation/bloc/circulations_cubit/circulations_cubit.dart';
import 'package:mms/features/circulation/ui/pages/circulation_page.dart';
import 'package:mms/features/circulation/ui/pages/circulations_page.dart';
import 'package:mms/features/interest/bloc/meeting_interests_cubit/meeting_interests_cubit.dart';
import 'package:mms/features/meeting_live/bloc/meeting_live_cubit/meeting_live_cubit.dart';
import 'package:mms/features/meetings/bloc/add_absence_cubit/add_absence_cubit.dart';
import 'package:mms/features/meetings/bloc/add_guest_cubit/add_guest_cubit.dart';
import 'package:mms/features/meetings/bloc/meeting_cubit/meeting_cubit.dart';
import 'package:mms/features/meetings/bloc/meetings_cubit/meetings_cubit.dart';
import 'package:mms/features/meetings/bloc/my_guest_suggestions_cubit/my_guest_suggestions_cubit.dart';
import 'package:mms/features/meetings/ui/pages/add_guest_page.dart';
import 'package:mms/features/meetings/ui/pages/calender_screen.dart';
import 'package:mms/features/meetings/ui/pages/meeting_page.dart';
import 'package:mms/features/notice_preferences/bloc/notice_preferences_cubit/notice_preferences_cubit.dart';
import 'package:mms/features/notification/ui/pages/notifications_page.dart';
import 'package:mms/features/profile/bloc/update_profile_cubit/update_profile_cubit.dart';
import 'package:mms/features/profile/ui/pages/profile_page.dart';
import 'package:mms/features/vote/bloc/create_vote_cubit/create_vote_cubit.dart';
import 'package:mms/features/vote/ui/pages/votes_page.dart';

/// Route names. Each one is also the route's path.
class RouteName {
  static const splash = '/';
  static const welcomeScreen = '/welcome';
  static const home = '/home';
  static const forgetPassword = '/forget-password';
  static const resetPasswordPage = '/reset-password';
  static const login = '/login';
  static const signup = '/signup';
  static const confirmCode = '/confirm-code';
  static const otpPassword = '/otp-password';
  static const donePage = '/done';
  static const committeePage = '/committee';
  static const profile = '/profile';
  static const meeting = '/meeting';
  static const calenderMeetings = '/committee-meetings';
  static const addGuest = '/add-guest';
  static const agenda = '/agenda';
  static const votes = '/votes';
  static const notifications = '/notifications';
  static const checkIn = '/check-in';
  static const checkInCode = '/check-in-code';
  static const circulations = '/circulations';
  static const circulation = '/circulation';
  static const fullScreen = '/full-screen';
}

/// Query parameter keys used by the routes.
class RouteParam {
  static const id = 'id';
  static const phone = 'phone';
}

/// `state.extra` of the agenda route.
typedef AgendaRouteArgs = ({Agenda agenda, MeetingCubit meetingCubit});

GoRoute _route(String name, GoRouterWidgetBuilder builder) => GoRoute(path: name, name: name, builder: builder);

final goRouter = GoRouter(
  navigatorKey: sl<GlobalKey<NavigatorState>>(),
  initialLocation: RouteName.splash,
  errorBuilder: (_, _) => const Scaffold(backgroundColor: AppColorManager.danger),
  routes: [
    //region auth
    _route(RouteName.splash, (_, _) => const SplashScreenPage()),
    _route(
      RouteName.login,
      (_, _) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => sl<LoginCubit>()),
          BlocProvider(create: (_) => sl<LoginSocialCubit>()),
        ],
        child: const LoginPage(),
      ),
    ),
    _route(
      RouteName.forgetPassword,
      (_, state) => BlocProvider(
        create: (_) => sl<ForgetPasswordCubit>(),
        child: ForgetPasswordPage(phone: state.uri.queryParameters[RouteParam.phone]),
      ),
    ),
    _route(
      RouteName.resetPasswordPage,
      (_, _) => BlocProvider(
        create: (_) => sl<ResetPasswordCubit>(),
        child: const ResetPasswordPage(),
      ),
    ),
    _route(
      RouteName.confirmCode,
      (_, _) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => sl<ConfirmCodeCubit>()),
          BlocProvider(create: (_) => sl<ResendCodeCubit>()),
        ],
        child: const ConfirmCodePage(),
      ),
    ),
    _route(
      RouteName.otpPassword,
      (_, _) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => sl<OtpPasswordCubit>()),
          BlocProvider(create: (_) => sl<ResendCodeCubit>()),
        ],
        child: const OtpPasswordPage(),
      ),
    ),
    _route(RouteName.donePage, (_, _) => const DonePage()),
    //endregion

    //region home & settings
    _route(
      RouteName.home,
      (_, _) => BlocProvider(
        create: (_) => sl<NoticePreferencesCubit>()..getData(),
        child: const HomePage(),
      ),
    ),
    _route(
      RouteName.profile,
      (_, _) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => sl<UpdateProfileCubit>()),
          BlocProvider(create: (_) => sl<FileCubit>()),
        ],
        child: const ProfilePage(),
      ),
    ),
    _route(
      RouteName.notifications,
      (_, _) => BlocProvider(
        create: (_) => sl<FileCubit>(),
        child: const NotificationsPage(),
      ),
    ),
    //endregion

    //region committee
    _route(
      RouteName.committeePage,
      (_, state) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => sl<CommitteeCubit>()..getData(uuid: state.uri.queryParameters[RouteParam.id] ?? ''),
          ),
          // For the "awaiting your vote" badge on the circulations entry.
          BlocProvider(
            create: (_) =>
                sl<CirculationsCubit>()..getData(committeeId: state.uri.queryParameters[RouteParam.id] ?? ''),
          ),
          // Role delegations and the "acting as" banner.
          BlocProvider(
            create: (_) =>
                sl<DelegationsCubit>()..getData(committeeId: state.uri.queryParameters[RouteParam.id] ?? ''),
          ),
        ],
        child: const CommitteePage(),
      ),
    ),
    _route(
      RouteName.circulations,
      (_, state) => BlocProvider(
        create: (_) => sl<CirculationsCubit>()..getData(committeeId: state.uri.queryParameters[RouteParam.id] ?? ''),
        child: const CirculationsPage(),
      ),
    ),
    _route(
      RouteName.circulation,
      (_, state) => BlocProvider(
        create: (_) => sl<CirculationCubit>()..getData(id: state.uri.queryParameters[RouteParam.id] ?? ''),
        child: const CirculationPage(),
      ),
    ),
    //endregion

    //region meeting
    _route(
      RouteName.meeting,
      (_, state) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => sl<MeetingCubit>()..getData(id: state.uri.queryParameters[RouteParam.id] ?? ''),
          ),
          BlocProvider(create: (_) => sl<AddAbsenceCubit>()),
          BlocProvider(create: (_) => sl<AddCommentCubit>()),
          BlocProvider(
            create: (_) =>
                sl<MyGuestSuggestionsCubit>()..getData(meetingId: state.uri.queryParameters[RouteParam.id] ?? ''),
          ),
          // My agenda item proposals.
          BlocProvider(
            create: (_) =>
                sl<MyAgendaRequestsCubit>()..getData(meetingId: state.uri.queryParameters[RouteParam.id] ?? ''),
          ),
          // Conflict-of-interest disclosures on the agenda items.
          BlocProvider(
            create: (_) =>
                sl<MeetingInterestsCubit>()..getData(meetingId: state.uri.queryParameters[RouteParam.id] ?? ''),
          ),
          // Live screen state; started by the page while the meeting is running.
          BlocProvider(create: (_) => sl<MeetingLiveCubit>()),
          // Quorum outside the live panel; fetched by the page with the meeting.
          BlocProvider(create: (_) => sl<QuorumCubit>()),
          // Live updates (SignalR) for this meeting; closed with the route.
          BlocProvider(
            create: (_) => sl<MeetingHubCubit>()
              ..start(
                meetingId: state.uri.queryParameters[RouteParam.id] ?? '',
                partyId: AppProvider.getParty.id,
              ),
          ),
        ],
        child: const MeetingPage(),
      ),
    ),
    _route(
      RouteName.checkIn,
      (_, state) => BlocProvider(
        create: (_) => sl<CheckInCubit>(),
        child: CheckInPage(meetingId: state.uri.queryParameters[RouteParam.id] ?? ''),
      ),
    ),
    _route(
      RouteName.checkInCode,
      (_, state) => BlocProvider(
        create: (_) => sl<CheckInCodeCubit>()..start(state.uri.queryParameters[RouteParam.id] ?? ''),
        child: const CheckInCodePage(),
      ),
    ),
    _route(
      RouteName.calenderMeetings,
      (_, state) => BlocProvider(
        create: (_) => sl<MeetingsCubit>()
          ..setFilterRequest(state.extra as FilterRequest?)
          ..getData(),
        child: const CalenderMeetingPage(),
      ),
    ),
    _route(
      RouteName.addGuest,
      (_, _) => BlocProvider(
        create: (_) => sl<AddGuestCubit>(),
        child: const AddGuestPage(),
      ),
    ),
    //endregion

    //region agenda
    _route(RouteName.agenda, (_, state) {
      final args = state.extra as AgendaRouteArgs;
      return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => sl<AddCommentCubit>()),
          BlocProvider.value(value: args.meetingCubit),
        ],
        child: AgendaPage(agenda: args.agenda),
      );
    }),
    //endregion

    //region votes
    _route(
      RouteName.votes,
      (_, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => sl<CreateVoteCubit>()),
          BlocProvider.value(value: state.extra as MeetingCubit),
        ],
        child: const VotesPage(),
      ),
    ),
    //endregion
  ],
);
