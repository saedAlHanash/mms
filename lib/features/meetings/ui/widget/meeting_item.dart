import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/features/meetings/data/response/meetings_response.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../router/app_router.dart';

class ItemMeeting extends StatelessWidget {
  const ItemMeeting({super.key, required this.item});

  final Meeting item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0).r,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0.r),
        color: AppColorManager.lightGray,
      ),
      child: Row(
        children: [
          Container(
            width: 20.0.w,
            height: 110.0.h,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.horizontal(left: Radius.circular(12.0.r)),
            ),
          ),
          Expanded(
            child: ListTile(
              onTap: () {
                Navigator.pushNamed(context, RouteName.meeting,
                    arguments: item.id);
              },
              title: DrawableText(
                text: item.title,
                fontFamily: FontManager.cairoBold.name,
                size: 20.0.sp,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.0.verticalSpace,
                  DrawableText(
                    text: item.status.realName,
                    color: item.status.color,
                  ),
                  3.0.verticalSpace,
                  Row(
                    children: [
                      DrawableText(
                        text: item.fromDate?.formatTime ?? '',
                      ),
                      10.0.horizontalSpace,
                      ImageMultiType(
                        url: Icons.arrow_forward,
                        color: Colors.grey,
                        height: 20.0.r,
                        width: 20.0.r,
                      ),
                      10.0.horizontalSpace,
                      DrawableText(text: item.toDate?.formatTime ?? ''),
                    ],
                  ),
                  3.0.verticalSpace,
                  DrawableText(
                    text: item.meetingPlace,
                    drawableStart: ImageMultiType(
                      url: Icons.place,
                      height: 15.0.r,
                      width: 15.0.r,
                    ),
                  ),
                ],
              ),
              trailing: ImageMultiType(
                url: Icons.arrow_forward_ios,
                height: 17.0.r,
                width: 17.0.r,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
