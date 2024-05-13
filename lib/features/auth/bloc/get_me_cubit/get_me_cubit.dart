// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mms/core/api_manager/api_url.dart';
// import 'package:mms/core/extensions/extensions.dart';
// import 'package:mms/features/profile/data/response/profile_response.dart';
//
// import '../../../../core/api_manager/api_service.dart';
// import '../../../../core/strings/enum_manager.dart';
// import '../../../../core/util/pair_class.dart';
// import '../../../../core/util/snack_bar_message.dart';
// import '../../data/response/login_response.dart';
//
// part 'get_me_state.dart';
//
// class GetMeCubit extends Cubit<GetMeInitial> {
//   GetMeCubit() : super(GetMeInitial.initial());
//
//
//   Future<void> getMe(BuildContext context,) async {
//     emit(state.copyWith(statuses: CubitStatuses.loading));
//     final pair = await _getMeApi();
//
//     if (pair.first == null) {
//       if (context.mounted) {
//         NoteMessage.showSnakeBar(message: pair.second ?? '', context: context);
//         emit(state.copyWith(statuses: CubitStatuses.error));
//       }
//        emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
//     } else {
//
//       // AppSharedPreference.cashLoginData(pair.first!);
//       APIService.reInitial();
//
//       emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
//     }
//   }
//
//   Future<Pair<Profile?, String?>> _getMeApi() async {
//
//       final response = await APIService()
//           .getApi(url: GetUrl.getMe);
//
//       if (response.statusCode.success) {
//         return Pair(LoginResponse.fromJson(response.jsonBody).data, null);
//       } else {
//           return response.getPairError;
//
//       }
//
//   }
// }
