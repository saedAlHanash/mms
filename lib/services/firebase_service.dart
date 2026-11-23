import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/app/app_provider.dart';

import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/core/util/shared_preferences.dart';
import 'package:mms/firebase_options.dart';
import 'package:mms/main.dart';

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

    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      String title = '';
      String body = '';

      if (notification != null) {
        title = notification.title ?? '';
        body = notification.body ?? '';
      } else {
        final model = FirebaseNotificationModel.fromJson(message.data);

        title = model.notification.title;
        body = model.notification.body;
      }

      if (title.isEmpty && body.isEmpty) return;
      // Tapping it opens the meeting (see NotificationOpenService).
      Note.showBigTextNotification(title: title, body: body, payload: pushTarget(message.data));
    });
  }

  static String get getFireTokenFromCache {
    final cashedToken = AppSharedPreference.getFireToken;

    if (cashedToken.isNotEmpty) return cashedToken;

    loggerObject.e('FCM Token Empty');

    throw Exception('FCM Token Empty');
  }

  static Future<String> getFireTokenAsync({bool reNew = false}) async {
    final cashedToken = AppSharedPreference.getFireToken;

    if (cashedToken.isNotEmpty) {
      insertFirebaseToken(cashedToken);
      return cashedToken;
    }

    String? token = '';

    try {
      token = await FirebaseMessaging.instance.getToken();
    } catch (e) {
      loggerObject.e(e);
    }

    if (token != null) AppSharedPreference.cashFireToken(token);
    insertFirebaseToken(token ?? '');
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

Future<void> insertFirebaseToken(String token) async {
  if (AppProvider.getParty.id.isBlank) return;
  await APIService().callApi(
    type: ApiType.patch,
    url: 'Party/UpdateDeviceToken',
    body: {
      "partyId": AppProvider.getParty.id,
      "deviceToken": token,
    },
  );
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
    final model = FirebaseNotificationModel.fromJson(message.data);

    title = model.notification.title;
    body = model.notification.body;
  }
  if (title.isEmpty && body.isEmpty) return;
  Note.showBigTextNotification(title: title, body: body, payload: pushTarget(message.data));
}

/// `MeetingId` of a push, read at the top level or inside `data`.
String pushMeetingId(Map<String, dynamic> data) {
  final top = (_valueOf(data, 'meetingId') ?? '').toString();
  return top.isNotEmpty ? top : FirebaseNotificationModel.fromJson(data).data.meetingId;
}

/// `CirculationId` of a push, read at the top level or inside `data`.
String pushCirculationId(Map<String, dynamic> data) {
  final top = (_valueOf(data, 'circulationId') ?? '').toString();
  return top.isNotEmpty ? top : FirebaseNotificationModel.fromJson(data).data.circulationId;
}

/// What tapping the push opens, kept as the local notification payload:
/// `circulation:<id>`, or the meeting id.
String pushTarget(Map<String, dynamic> data) {
  final circulationId = pushCirculationId(data);
  if (circulationId.isNotEmpty) return '$circulationTargetPrefix$circulationId';
  final meetingId = pushMeetingId(data);
  if (meetingId.isNotEmpty) return meetingId;
  // Role delegation notices carry `{CommitteeId, DelegationId}`.
  final committeeId = pushCommitteeId(data);
  return committeeId.isNotEmpty ? '$committeeTargetPrefix$committeeId' : '';
}

/// `CommitteeId` of a push, read at the top level or inside `data`.
String pushCommitteeId(Map<String, dynamic> data) {
  final top = (_valueOf(data, 'committeeId') ?? '').toString();
  return top.isNotEmpty ? top : FirebaseNotificationModel.fromJson(data).data.committeeId;
}

const circulationTargetPrefix = 'circulation:';

const committeeTargetPrefix = 'committee:';

class FirebaseNotificationModel {
  FirebaseNotificationModel({
    required this.notification,
    required this.type,
    required this.data,
  });

  final Notification notification;
  final String type;
  final Data data;

  /// Never throws: `notification` and `data` may be JSON strings, maps or missing,
  /// and keys may be PascalCase or camelCase (the push format isn't fixed).
  factory FirebaseNotificationModel.fromJson(Map<String, dynamic> json) {
    final notification = _decodeMap(_valueOf(json, 'notification'));
    return FirebaseNotificationModel(
      // Data-only pushes may put the title and body at the top level.
      notification: Notification.fromJson(notification.isEmpty ? json : notification),
      type: (_valueOf(json, 'type') ?? '').toString(),
      data: Data(payload: _decodeMap(_valueOf(json, 'data'))),
    );
  }

  Map<String, dynamic> toJson() => {
        "notification": notification.toJson(),
        "Type": type,
        "data": data.toJson(),
      };
}

/// [key] looked up without case (`MeetingId`, `meetingId`).
Object? _valueOf(Map json, String key) {
  final lower = key.toLowerCase();
  for (final entry in json.entries) {
    if (entry.key.toString().toLowerCase() == lower) return entry.value;
  }
  return null;
}

Map<String, dynamic> _decodeMap(Object? value) {
  try {
    final decoded = value is String && value.trim().isNotEmpty ? jsonDecode(value) : value;
    if (decoded is Map) return decoded.map((k, v) => MapEntry(k.toString(), v));
  } catch (_) {}
  return {};
}

/// The push `data` payload, e.g. `{MeetingId}`, `{minuteId, MeetingId}`, `{MeetingTaskId, MeetingId}`.
class Data {
  Data({required this.payload});

  final Map<String, dynamic> payload;

  String get meetingId => (_valueOf(payload, 'meetingId') ?? '').toString();

  String get circulationId => (_valueOf(payload, 'circulationId') ?? '').toString();

  String get committeeId => (_valueOf(payload, 'committeeId') ?? '').toString();

  Map<String, dynamic> toJson() => payload;
}

class Notification {
  Notification({
    required this.title,
    required this.body,
    required this.sound,
  });

  final String title;
  final String body;
  final String sound;

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      title: (_valueOf(json, 'title') ?? '').toString(),
      body: (_valueOf(json, 'body') ?? '').toString(),
      sound: (_valueOf(json, 'sound') ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "Title": title,
        "Body": body,
        "Sound": sound,
      };
}
