import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/widgets/icon_tile.dart';
import 'package:mms/features/notification/data/response/notification_response.dart';

/// Notification row: bell tile + title / time + body. No read state, no tap.
class NotificationWidget extends StatelessWidget {
  const NotificationWidget({
    super.key,
    required this.item,
  });

  final NotificationModel item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.0.h),
      child: Row(
        crossAxisAlignment: .start,
        children: [
          const IconTile(icon: Icons.notifications_none_rounded, size: 40, iconSize: 20),
          12.0.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Row(
                  crossAxisAlignment: .start,
                  children: [
                    Expanded(
                      child: DrawableText(
                        text: item.title,
                        size: 15.0.sp,
                        fontWeight: .w600,
                        color: AppColorManager.neutral900,
                      ),
                    ),
                    if (item.date != null) ...[
                      8.0.horizontalSpace,
                      Directionality(
                        textDirection: .ltr,
                        child: DrawableText(
                          text: item.date!.formatTime,
                          size: 12.0.sp,
                          color: AppColorManager.neutral500,
                        ),
                      ),
                    ],
                  ],
                ),
                if (item.body.isNotEmpty)
                  DrawableText(
                    text: item.body,
                    size: 13.0.sp,
                    color: AppColorManager.neutral500,
                    matchParent: true,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
