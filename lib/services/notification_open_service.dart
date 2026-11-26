import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/app/app_widget.dart';
import 'package:mms/features/committees/bloc/my_committees_cubit/my_committees_cubit.dart';
import 'package:mms/features/committees/data/response/committees_response.dart';
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
    if (target.startsWith(committeeTargetPrefix)) {
      final id = target.substring(committeeTargetPrefix.length);
      goRouter.pushNamed(RouteName.committeePage, queryParameters: {RouteParam.id: id});
      return;
    }
    if (target.startsWith(recommendationTargetPrefix)) {
      _openRecommendations(target.substring(recommendationTargetPrefix.length).split(','));
      return;
    }
    if (target.startsWith(itemTargetPrefix)) {
      final id = target.substring(itemTargetPrefix.length);
      // A committee reminder opens the committee (its Attendance card is there);
      // anything else with only an item id is a circulation reminder.
      if (_committee(id) != null) {
        goRouter.pushNamed(RouteName.committeePage, queryParameters: {RouteParam.id: id});
      } else {
        goRouter.pushNamed(RouteName.circulation, queryParameters: {RouteParam.id: id});
      }
      return;
    }
    goRouter.pushNamed(RouteName.meeting, queryParameters: {RouteParam.id: target});
  }

  /// Raised recommendations reach the parent's chair and secretary, and the answers
  /// reach the sub-committee's: open the one of the two where I lead, else mine.
  static void _openRecommendations(List<String> ids) {
    final candidates = ids.where((e) => e.isNotEmpty).toList().reversed.map(_committee).nonNulls.toList();
    final committee =
        candidates.firstWhereOrNull((e) => e.member.membershipType.isLead) ?? candidates.firstOrNull;
    final id = committee?.id ?? ids.firstWhere((e) => e.isNotEmpty, orElse: () => '');
    if (id.isEmpty) return;
    goRouter.pushNamed(
      RouteName.recommendations,
      queryParameters: {
        RouteParam.id: id,
        'lead': (committee?.member.membershipType.isLead ?? false) ? '1' : '0',
      },
    );
  }

  static Committee? _committee(String id) {
    final context = ctx;
    if (context == null) return null;
    return context.read<MyCommitteesCubit>().state.result.firstWhereOrNull((e) => e.id == id);
  }
}
