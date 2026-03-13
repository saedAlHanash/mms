import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:m_cubit/caching_service/caching_service.dart';
import 'package:mms/core/error/error_manager.dart';
import 'package:mms/services/app_info_service.dart';
import 'package:mms/services/firebase_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/api_manager/api_service.dart';
import 'core/app/app_widget.dart';
import 'core/app/bloc/loading_cubit.dart';
import 'core/injection/injection_container.dart' as di;
import 'core/util/shared_preferences.dart';

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferences.getInstance().then((value) {
    AppSharedPreference.init(value);
  });

  await CachingService.initial(
    onError: (second) => showErrorFromApi(second),
    version: 1,
    timeInterval: 60,
  );

  await FirebaseService.initial();
  requestPermissions();

  await AppInfoService.initial();

  await Note.initialize();

  await di.init();

  HttpOverrides.global = MyHttpOverrides();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<LoadingCubit>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        return true;
      };
  }
}

Future<void> requestPermissions() async {
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

class Note {
  static Future initialize() async {
    var androidInitialize = const AndroidInitializationSettings('mipmap/ic_launcher');
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationsSettings = InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    await flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  }

  static Future showBigTextNotification({
    var id = 0,
    required String title,
    required String body,
    var payload,
  }) async {
    // var vibrationPattern = Int64List(2);
    // vibrationPattern[0] = 1000;
    // vibrationPattern[1] = 1000;

    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'MMS',
      'MMS app',
      playSound: true,
      // enableVibration: true,
      // sound: RawResourceAndroidNotificationSound('sound'),
      // vibrationPattern: vibrationPattern,
      importance: Importance.defaultImportance,
      priority: Priority.high,
    );

    var not = const NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: DarwinNotificationDetails(),
    );

    await flutterLocalNotificationsPlugin.show((DateTime.now().millisecondsSinceEpoch ~/ 1000), title, body, not);
  }
}
