import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/agendas/bloc/add_comment_cubit/add_comment_cubit.dart';
import '../../features/auth/bloc/confirm_code_cubit/confirm_code_cubit.dart';
import '../../features/auth/bloc/forget_password_cubit/forget_password_cubit.dart';
import '../../features/auth/bloc/get_me_cubit/get_me_cubit.dart';
import '../../features/auth/bloc/login_cubit/login_cubit.dart';
import '../../features/auth/bloc/login_social_cubit/login_social_cubit.dart';
import '../../features/auth/bloc/otp_password_cubit/otp_password_cubit.dart';
import '../../features/auth/bloc/resend_code_cubit/resend_code_cubit.dart';
import '../../features/auth/bloc/reset_password_cubit/reset_password_cubit.dart';
import '../../features/committees/bloc/committee_cubit/committee_cubit.dart';
import '../../features/committees/bloc/my_committees_cubit/my_committees_cubit.dart';
import '../../features/files/bloc/upload_file_cubit/upload_file_cubit.dart';
import '../../features/meetings/bloc/add_absence_cubit/add_absence_cubit.dart';
import '../../features/meetings/bloc/add_guest_cubit/add_guest_cubit.dart';
import '../../features/meetings/bloc/meeting_cubit/meeting_cubit.dart';
import '../../features/meetings/bloc/meetings_cubit/meetings_cubit.dart';
import '../../features/notification/bloc/notifications_cubit/notifications_cubit.dart';
import '../../features/profile/bloc/update_profile_cubit/update_profile_cubit.dart';
import '../../features/room/bloc/room_cubit/room_cubit.dart';
import '../../features/vote/bloc/create_vote_cubit/create_vote_cubit.dart';
import '../../features/vote/bloc/delete_vote_cubit/delete_vote_cubit.dart';
import '../../features/vote/bloc/vote_cubit/vote_cubit.dart';
import '../../features/vote/bloc/votes_cubit/votes_cubit.dart';
import '../app/bloc/loading_cubit.dart';
import '../network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //region liveKit
  sl.registerFactory(() => RoomCubit());
  //endregion

  //region Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker.instance);
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
  //endregion

//! External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
