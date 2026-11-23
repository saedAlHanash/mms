import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/core/widgets/icon_tile.dart';
import 'package:mms/features/meetings/data/response/meetings_response.dart';
import 'package:mms/generated/l10n.dart';
import 'package:mms/router/go_router.dart';

/// "Show the hall QR" for the secretary, while check-in is open in the hall.
class CheckInCodeEntry extends StatelessWidget {
  const CheckInCodeEntry({super.key, required this.meeting});

  final Meeting meeting;

  static bool showsFor(Meeting meeting) {
    if (meeting.callerMembershipType != MembershipType.secretary) return false;
    if (meeting.status != MeetingStatus.scheduled && meeting.status != MeetingStatus.running) return false;
    return meeting.mode != MeetingMode.online;
  }

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(16.0.r);
    return Material(
      color: AppColorManager.neutral0,
      borderRadius: radius,
      child: InkWell(
        borderRadius: radius,
        onTap: () => context.pushNamed(RouteName.checkInCode, queryParameters: {RouteParam.id: meeting.id}),
        child: Ink(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 14.0.h),
          decoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(color: AppColorManager.neutral100),
          ),
          child: Row(
            children: [
              const IconTile(icon: Icons.qr_code_2_rounded, size: 44),
              12.0.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    DrawableText(
                      text: S.of(context).checkInCodeShow,
                      size: 15.0.sp,
                      fontWeight: .w700,
                      color: AppColorManager.neutral900,
                    ),
                    2.0.verticalSpace,
                    DrawableText(
                      text: S.of(context).checkInCodeShowHint,
                      size: 13.0.sp,
                      color: AppColorManager.neutral500,
                    ),
                  ],
                ),
              ),
              ImageMultiType(
                url: Directionality.of(context) == .rtl ? Icons.chevron_left_rounded : Icons.chevron_right_rounded,
                width: 22.0.r,
                height: 22.0.r,
                color: AppColorManager.neutral500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
