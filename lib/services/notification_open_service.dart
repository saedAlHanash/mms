import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mms/core/app/app_provider.dart';
import 'package:mms/main.dart';
import 'package:mms/router/go_router.dart';
import 'package:mms/services/firebase_service.dart';

/// Opens what a notification is about when the user taps it.
///
/// Push `data` carries `MeetingId` for meeting, minutes, mention and task
/// notices, and `CirculationId` for circulation notices (see [pushTarget]). Taps that arrive before the home page is up (cold start) wait in
/// [_pending] until [openPending] is called from the home page.
class NotificationOpenService {
  NotificationOpenService._();

  static String? _pending;
  static bool _homeReady = false;

  /// Wires the three tap sources: local notifications, FCM in background, FCM cold start.
  static Future<void> init() async {
    FirebaseMessaging.onMessageOpenedApp.listen((message) => _openFromData(message.data));

    final initial = await FirebaseMessaging.instance.getInitialMessage();
    if (initial != null) _openFromData(initial.data);

    final launch = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (launch?.didNotificationLaunchApp ?? false) {
      onLocalTap(launch!.notificationResponse);
    }
  }

  /// `payload` of a local notification is [pushTarget].
  static void onLocalTap(NotificationResponse? response) => _open(response?.payload ?? '');

  /// Called by the home page once it's shown.
  static void openPending() {
    _homeReady = true;
    final id = _pending;
    _pending = null;
    if (id != null) _open(id);
  }

  static void _openFromData(Map<String, dynamic> data) => _open(pushTarget(data));

  static void _open(String target) {
    if (target.isEmpty || AppProvider.isNotLogin) return;
    if (!_homeReady) {
      _pending = target;
      return;
    }
    if (target.startsWith(circulationTargetPrefix)) {
      final id = target.substring(circulationTargetPrefix.length);
      goRouter.pushNamed(RouteName.circulation, queryParameters: {RouteParam.id: id});
      return;
    }
    goRouter.pushNamed(RouteName.meeting, queryParameters: {RouteParam.id: target});
  }
}
