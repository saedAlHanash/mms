import 'dart:convert';

import 'package:mms/features/members/data/response/member_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/response/login_response.dart';
import '../strings/enum_manager.dart';

class AppSharedPreference {
  static const _token = '1';
  static const _phoneNumber = '2';
  static const _fireToken = '3';
  static const _lang = '4';
  static const _screenType = '5';
  static const _user = '6';
  static const _notifications = '7';
  static const _party = '8';

  static late SharedPreferences _prefs;

  static init(SharedPreferences preferences) async {
    _prefs = preferences;
  }

  static cashToken(String? token) {
    if (token == null) return;
    _prefs.setString(_token, token);
  }

  static String get getToken => _prefs.getString(_token) ?? '';

  static cashUser(LoginResponse user) async {
    final json = user.toJson();
    await _prefs.setString(_user, jsonEncode(json));
  }

  static LoginResponse get getUser =>
      LoginResponse.fromJson(jsonDecode(_prefs.getString(_user) ?? '{}'));

  static cashParty(Party user) async {
    final json = user.toJson();
    await _prefs.setString(_party, jsonEncode(json));
  }

  static Party get getParty =>
      Party.fromJson(jsonDecode(_prefs.getString(_party) ?? '{}'));

  static void cashFireToken(String token) {
    _prefs.setString(_fireToken, token);
  }

  static String get getFireToken => _prefs.getString(_fireToken) ?? '';

  static cashPhone(String? phone) async {
    if (phone == null) return;
    await _prefs.setString(_phoneNumber, phone);
  }

  static String get getPhone {
    return _prefs.getString(_phoneNumber) ?? '';
  }

  static Future<void> removePhone() async {
    await _prefs.remove(_phoneNumber);
  }

  static cashStartPage(StartPage type) async {
    await _prefs.setInt(_screenType, type.index);
  }

  static StartPage get getStartPage =>
      StartPage.values[_prefs.getInt(_screenType) ?? 0];

  static Future<void> clear() async => await _prefs.clear();

  static Future<void> logout() async => await _prefs.clear();

  static Future<void> cashLocal(String langCode) async {
    await _prefs.setString(_lang, langCode);
  }

  static String get getLocal => _prefs.getString(_lang) ?? 'en';

  static cashNotificationState(bool n) {
    _prefs.setBool(_notifications, n);
  }

  static bool get getNotificationState =>
      _prefs.getBool(_notifications) ?? true;
}
