import 'package:mms/features/meeting_hub/bloc/meeting_hub_cubit/meeting_hub_cubit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mms/features/agendas/bloc/add_comment_cubit/add_comment_cubit.dart';
import 'package:mms/features/auth/bloc/confirm_code_cubit/confirm_code_cubit.dart';
import 'package:mms/features/auth/bloc/forget_password_cubit/forget_password_cubit.dart';
import 'package:mms/features/auth/bloc/get_me_cubit/get_me_cubit.dart';
import 'package:mms/features/auth/bloc/login_cubit/login_cubit.dart';
import 'package:mms/features/auth/bloc/login_social_cubit/login_social_cubit.dart';
import 'package:mms/features/auth/bloc/otp_password_cubit/otp_password_cubit.dart';
import 'package:mms/features/auth/bloc/resend_code_cubit/resend_code_cubit.dart';
import 'package:mms/features/auth/bloc/reset_password_cubit/reset_password_cubit.dart';
import 'package:mms/features/committees/bloc/committee_cubit/committee_cubit.dart';
import 'package:mms/features/committees/bloc/my_committees_cubit/my_committees_cubit.dart';
import 'package:mms/features/files/bloc/upload_file_cubit/upload_file_cubit.dart';
import 'package:mms/features/meetings/bloc/add_absence_cubit/add_absence_cubit.dart';
import 'package:mms/features/meetings/bloc/add_guest_cubit/add_guest_cubit.dart';
import 'package:mms/features/meetings/bloc/meeting_cubit/meeting_cubit.dart';
import 'package:mms/features/meetings/bloc/meetings_cubit/meetings_cubit.dart';
import 'package:mms/features/check_in/bloc/check_in_cubit/check_in_cubit.dart';
import 'package:mms/features/agenda_request/bloc/my_agenda_requests_cubit/my_agenda_requests_cubit.dart';
import 'package:mms/features/circulation/bloc/circulation_cubit/circulation_cubit.dart';
import 'package:mms/features/circulation/bloc/circulations_cubit/circulations_cubit.dart';
import 'package:mms/features/interest/bloc/meeting_interests_cubit/meeting_interests_cubit.dart';
import 'package:mms/features/meeting_live/bloc/meeting_live_cubit/meeting_live_cubit.dart';
import 'package:mms/features/meetings/bloc/my_guest_suggestions_cubit/my_guest_suggestions_cubit.dart';
import 'package:mms/features/notice_preferences/bloc/notice_preferences_cubit/notice_preferences_cubit.dart';
import 'package:mms/features/notification/bloc/notifications_cubit/notifications_cubit.dart';
import 'package:mms/features/profile/bloc/update_profile_cubit/update_profile_cubit.dart';
import 'package:mms/features/room/bloc/my_status_cubit/my_status_cubit.dart';
import 'package:mms/features/room/bloc/room_cubit/room_cubit.dart';
import 'package:mms/features/room/bloc/user_control_cubit/user_control_cubit.dart';
import 'package:mms/features/vote/bloc/create_vote_cubit/create_vote_cubit.dart';
import 'package:mms/features/vote/bloc/delete_vote_cubit/delete_vote_cubit.dart';
import 'package:mms/features/vote/bloc/vote_cubit/vote_cubit.dart';
import 'package:mms/features/vote/bloc/votes_cubit/votes_cubit.dart';
import 'package:mms/core/app/bloc/loading_cubit.dart';
import 'package:mms/core/network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //region liveKit
  sl.registerFactory(() => RoomCubit());
  sl.registerFactory(() => MyStatusCubit());
  sl.registerFactory(() => UserControlCubit());
  //endregion

  //region Core

  // sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectionChecker: sl()));
  // sl.registerLazySingleton(() => InternetConnectionChecker.instance);
  sl.registerLazySingleton(() => LoadingCubit());
  sl.registerLazySingleton(() => GlobalKey<NavigatorState>());

  //endregion

  //region auth

  sl.registerFactory(() => LoginCubit());
  sl.registerFactory(() => LoginSocialCubit());
  sl.registerFactory(() => ForgetPasswordCubit());
  sl.registerFactory(() => ResetPasswordCubit());
  sl.registerFactory(() => ConfirmCodeCubit());
  sl.registerFactory(() => ResendCodeCubit());
  sl.registerFactory(() => OtpPasswordCubit());
  sl.registerFactory(() => UpdateProfileCubit());
  sl.registerFactory(() => LoggedPartyCubit());

  //endregion

  // region profile
  sl.registerFactory(() => FileCubit());
  //endregion

  //region Committees
  sl.registerFactory(() => MyCommitteesCubit());
  sl.registerFactory(() => CommitteeCubit());

  //endregion

  //region Meetings
  sl.registerFactory(() => MeetingsCubit());
  sl.registerFactory(() => MeetingCubit());
  sl.registerFactory(() => AddGuestCubit());
  sl.registerFactory(() => AddAbsenceCubit());
  sl.registerFactory(() => MeetingHubCubit());
  sl.registerFactory(() => AddCommentCubit());

  //endregion

  //region Cart

  //endregion

  //region category

  //endregion

  //region Governors

  //endregion

  //region product

  //endregion

  //region Vote

  sl.registerFactory(() => VoteCubit());
  sl.registerFactory(() => VotesCubit());
  sl.registerFactory(() => CreateVoteCubit());
  sl.registerFactory(() => DeleteVoteCubit());

  //endregion

  //region chat

  //endregion

  //region manufacturers

  //endregion

  //region notifications
  sl.registerFactory(() => NotificationsCubit());
  sl.registerFactory(() => NoticePreferencesCubit());
  sl.registerFactory(() => MyGuestSuggestionsCubit());
  sl.registerFactory(() => MeetingLiveCubit());
  sl.registerFactory(() => MeetingInterestsCubit());
  sl.registerFactory(() => MyAgendaRequestsCubit());
  sl.registerFactory(() => CirculationsCubit());
  sl.registerFactory(() => CirculationCubit());
  sl.registerFactory(() => CheckInCubit());
  //endregion

  //! External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
