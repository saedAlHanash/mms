import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mms/core/api_manager/api_url.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/util/shared_preferences.dart';
import 'package:mms/features/auth/data/request/login_request.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/login_response.dart';

part 'login_social_state.dart';

class LoginSocialCubit extends Cubit<LoginSocialInitial> {
  LoginSocialCubit() : super(LoginSocialInitial.initial());

  Future<void> loginGoogle() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));

    final fireAuthUser = await _googleSignIn();

    if (fireAuthUser == null) {
      emit(state.copyWith(statuses: CubitStatuses.init));
      return;
    }

    final pair = await _loginSocialApi(user: fireAuthUser);

    await _googleSignOut();

    if (pair.first == null) {
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<void> _googleSignOut() async {
    try {
      await GoogleSignIn().disconnect();
      await GoogleSignIn().signOut();
      loggerObject.w('GoogleSignIn signOut');
    } catch (e) {
      loggerObject.e(e);
    }
  }

  Future<UserCredential?> _googleSignIn() async {
    try {
      final googleAccount = await GoogleSignIn().signIn();

      final googleAuthentication = await googleAccount!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuthentication.accessToken,
        idToken: googleAuthentication.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      loggerObject.e(e);
      return null;
    }
  }

  Future<Pair<LoginResponse?, String?>> _loginSocialApi(
      {required UserCredential user}) async {
    final response = await APIService().postApi(
      url: PostUrl.loginSocial,
      body: {
        "email": user.user?.email,
        "provider_id": user.user?.uid,
        "name": user.user?.displayName,
        "provider": 'google',
      },
    );

    if (response.statusCode.success) {
      final pair = Pair(LoginResponse.fromJson(response.jsonBody), null);

      AppSharedPreference.cashToken(pair.first.accessToken);
      AppSharedPreference.removePhone();
      APIService.reInitial();

      return pair;
    } else {
      return response.getPairError;
    }
  }
}
