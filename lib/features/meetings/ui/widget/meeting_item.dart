import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/widgets/status_chip.dart';
import 'package:mms/features/meetings/data/response/meetings_response.dart';
import 'package:mms/router/app_router.dart';

/// Meeting card used by the calendar lists.
class ItemMeeting extends StatelessWidget {
  const ItemMeeting({super.key, required this.item, this.showCommittee = true});

  final Meeting item;

  /// Hide the committee name when the list is already scoped to one committee.
  final bool showCommittee;

  Widget _infoRow(IconData icon, Widget text) {
    return Row(
      children: [
        ImageMultiType(url: icon, width: 15.0.r, height: 15.0.r, color: AppColorManager.neutral500),
        6.0.horizontalSpace,
        Flexible(child: text),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final time = '${item.fromDate?.formatTime ?? ''} – ${item.toDate?.formatTime ?? ''}';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 5.0.h),
      child: Material(
        color: AppColorManager.neutral0,
        borderRadius: BorderRadius.circular(12.0.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(12.0.r),
          onTap: () => Navigator.pushNamed(context, RouteName.meeting, arguments: item.id),
          child: Ink(
            padding: EdgeInsets.symmetric(horizontal: 14.0.w, vertical: 12.0.h),
            decoration: BoxDecoration(
              border: Border.all(color: AppColorManager.neutral100),
              borderRadius: BorderRadius.circular(12.0.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Row(
                        children: [
                          StatusChip.meeting(item.status),
                          if (showCommittee && item.committeeName.isNotEmpty) ...[
                            8.0.horizontalSpace,
                            Flexible(
                              child: DrawableText(
                                text: item.committeeName,
                                size: 12.0.sp,
                                fontWeight: .w600,
                                color: AppColorManager.primary600,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ],
                      ),
                      3.0.verticalSpace,
                      DrawableText(
                        text: item.title,
                        size: 16.0.sp,
                        fontWeight: .w700,
                        color: AppColorManager.neutral900,
                        matchParent: true,
                      ),
                      3.0.verticalSpace,
                      _infoRow(
                        Icons.access_time_rounded,
                        Directionality(
                          textDirection: .ltr,
                          child: DrawableText(text: time, size: 13.0.sp, color: AppColorManager.neutral700),
                        ),
                      ),
                      if (item.meetingPlace.isNotEmpty) ...[
                        3.0.verticalSpace,
                        _infoRow(
                          Icons.place_outlined,
                          DrawableText(
                            text: item.meetingPlace,
                            size: 13.0.sp,
                            color: AppColorManager.neutral700,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                10.0.horizontalSpace,
                ImageMultiType(
                  url: Icons.arrow_forward_ios_rounded,
                  width: 18.0.r,
                  height: 18.0.r,
                  color: AppColorManager.neutral500,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
