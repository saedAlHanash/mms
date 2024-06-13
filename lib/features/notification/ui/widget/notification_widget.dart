import 'package:drawable_text/drawable_text.dart';

import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../data/response/notification_response.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({
    super.key,
    required this.item,
  });

  final NotificationModel item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          horizontalTitleGap: 10.0.w,
          leading: ImageMultiType(
            url: Icons.notifications,
            width: 25.0.r,
            color: AppColorManager.mainColor,
          ),
          title: DrawableText(
            text: item.title,
            color: Colors.black87,
          ),
          subtitle: DrawableText(
            matchParent: true,
            text: item.body,
            size: 14.0.sp,
            color: AppColorManager.grey,
          ),
          trailing: DrawableText(
            text: item.getCreatedAt,
            color: Colors.grey,
            size: 11.0.sp,
          ),
        ),
        Divider(
            color: AppColorManager.cardColor,
            endIndent: 20.0.w,
            indent: 20.0.w),
      ],
    );
  }
}
