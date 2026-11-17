import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/widgets/app_bar/app_bar_widget.dart';
import 'package:mms/core/widgets/empty_state_widget.dart';
import 'package:mms/core/widgets/refresh_widget/refresh_widget.dart';
import 'package:mms/core/widgets/small_widgets.dart';
import 'package:mms/features/notification/bloc/notifications_cubit/notifications_cubit.dart';
import 'package:mms/features/notification/data/response/notification_response.dart';
import 'package:mms/features/notification/ui/widgets/notification_widget.dart';
import 'package:mms/generated/l10n.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  void initState() {
    super.initState();
    // Opening the page means the user has seen the current notifications.
    context.read<NotificationsCubit>().markAllAsRead();
  }

  /// "Today" / "Yesterday" / yyyy/MM/dd — grouping is display-only.
  String _dayLabel(BuildContext context, DateTime? date) {
    if (date == null) return '';
    final now = DateTime.now();
    final day = DateTime(date.year, date.month, date.day);
    final today = DateTime(now.year, now.month, now.day);
    final diff = today.difference(day).inDays;
    if (diff == 0) return S.of(context).today;
    if (diff == 1) return S.of(context).yesterday;
    return date.formatDate;
  }

  List<Widget> _groupedItems(BuildContext context, List<NotificationModel> list) {
    final children = <Widget>[];
    String? lastLabel;
    for (final item in list) {
      final label = _dayLabel(context, item.date);
      if (label != lastLabel) {
        lastLabel = label;
        if (label.isNotEmpty) {
          children.add(Padding(
            padding: EdgeInsets.fromLTRB(20.0.w, 12.0.h, 20.0.w, 4.0.h),
            child: Directionality(
              textDirection: item.date != null && label == item.date!.formatDate
                  ? TextDirection.ltr
                  : Directionality.of(context),
              child: DrawableText(
                text: label,
                size: 13.0.sp,
                fontWeight: .w700,
                color: AppColorManager.neutral500,
              ),
            ),
          ));
        }
      }
      children.add(NotificationWidget(item: item));
    }
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleText: S.of(context).notifications),
      body: BlocConsumer<NotificationsCubit, NotificationsInitial>(
        // New notifications loaded while this page is open are seen too.
        listenWhen: (p, c) => c.done && c.result != p.result,
        listener: (context, state) => context.read<NotificationsCubit>().markAllAsRead(),
        builder: (context, state) {
          final list = state.result;

          final Widget body;
          if (state.loading && list.isEmpty) {
            body = ListView(
              padding: EdgeInsets.all(20.0.r),
              children: [
                for (var i = 0; i < 6; i++) ...[
                  if (i > 0) 20.0.verticalSpace,
                  Row(
                    crossAxisAlignment: .start,
                    children: [
                      SkeletonBox(width: 40.0.r, height: 40, radius: 10),
                      12.0.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            const FractionallySizedBox(widthFactor: 0.55, child: SkeletonBox(height: 14, radius: 6)),
                            8.0.verticalSpace,
                            const FractionallySizedBox(widthFactor: 0.9, child: SkeletonBox(height: 12, radius: 6)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            );
          } else if (list.isEmpty) {
            body = ListView(
              padding: EdgeInsets.only(top: 120.0.h),
              children: [
                EmptyStateWidget.large(
                  icon: Icons.notifications_none_rounded,
                  title: S.of(context).noNotifications,
                  description: S.of(context).noNotificationsDescription,
                ),
              ],
            );
          } else {
            body = ListView(
              padding: EdgeInsets.only(top: 8.0.h, bottom: 24.0.h),
              children: _groupedItems(context, list),
            );
          }

          return RefreshWidget(
            isLoading: state.loading,
            onRefresh: () async {
              context.read<NotificationsCubit>().getData(newData: true);
            },
            child: body,
          );
        },
      ),
    );
  }
}
