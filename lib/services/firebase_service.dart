import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../core/api_manager/api_service.dart';
import '../core/util/shared_preferences.dart';
import '../firebase_options.dart';

class FirebaseService {
  static Future<void> initial() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await getFireTokenAsync();
    setListener();
  }

  static void setListener() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.instance.onTokenRefresh.listen((event) {});
  }

  static String get getFireTokenFromCache {
    final cashedToken = AppSharedPreference.getFireToken;

    if (cashedToken.isNotEmpty) return cashedToken;

    loggerObject.e('FCM Token Empty');

    throw Exception('FCM Token Empty');
  }

  static Future<String> getFireTokenAsync({bool reNew = false}) async {
    final cashedToken = AppSharedPreference.getFireToken;

    if (cashedToken.isNotEmpty) return cashedToken;

    final token = await FirebaseMessaging.instance.getToken();

    if (token != null) AppSharedPreference.cashFireToken(token);

    return token ?? '';
  }

  static Future<void> requestPermissions() async {
    try {
      FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    } on Exception {
      loggerObject.e('error FCM ios ');
    }
  }
}
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final notification = message.notification;

  String title = '';
  String body = '';

  if (notification != null) {
    title = notification.title ?? '';
    body = notification.body ?? '';
  } else {
    title = message.data['title'] ?? '';
    body = message.data['body'] ?? '';
  }
}
