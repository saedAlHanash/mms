import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/core/widgets/my_card_widget.dart';
import 'package:mms/features/meetings/bloc/meeting_cubit/meeting_cubit.dart';
import 'package:mms/features/meetings/data/response/meetings_response.dart';
import 'package:mms/generated/l10n.dart';
import 'package:mms/router/go_router.dart';

/// Check-in on the meeting page: the "Check in" button, or the recorded time.
class CheckInCard extends StatelessWidget {
  const CheckInCard({super.key, required this.meeting});

  final Meeting meeting;

  /// Shown to an invited attendee while the meeting is scheduled or running,
  /// unless it is held online only (there is no hall QR then).
  static bool showsFor(Meeting meeting) {
    if (meeting.status != MeetingStatus.scheduled && meeting.status != MeetingStatus.running) return false;
    if (meeting.mode == MeetingMode.online) return false;
    return meeting.attendeesList.any((e) => e.partyId == AppProvider.getParty.id);
  }

  @override
  Widget build(BuildContext context) {
    final me = meeting.attendeesList.firstWhereOrNull((e) => e.partyId == AppProvider.getParty.id);
    final checkedInAt = me?.checkedInAt;

    if (checkedInAt != null) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 14.0.h),
        decoration: BoxDecoration(
          color: AppColorManager.successSoft,
          borderRadius: BorderRadius.circular(16.0.r),
        ),
        child: Row(
          children: [
            ImageMultiType(
              url: Icons.verified_rounded,
              width: 22.0.r,
              height: 22.0.r,
              color: AppColorManager.success,
            ),
            10.0.horizontalSpace,
            DrawableText(
              text: S.of(context).checkedInAt,
              size: 14.0.sp,
              fontWeight: .w600,
              color: AppColorManager.successText,
            ),
            6.0.horizontalSpace,
            Directionality(
              textDirection: .ltr,
              child: DrawableText(
                text: checkedInAt.formatTime,
                size: 14.0.sp,
                fontWeight: .w700,
                color: AppColorManager.successText,
              ),
            ),
          ],
        ),
      );
    }

    return MyCardWidget(
      tone: .soft,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.all(16.0.r),
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          Row(
            children: [
              Container(
                width: 44.0.r,
                height: 44.0.r,
                alignment: .center,
                decoration: BoxDecoration(
                  color: AppColorManager.primary50,
                  borderRadius: BorderRadius.circular(12.0.r),
                ),
                child: ImageMultiType(
                  url: Icons.qr_code_2_rounded,
                  width: 24.0.r,
                  height: 24.0.r,
                  color: AppColorManager.primary500,
                ),
              ),
              12.0.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    DrawableText(
                      text: S.of(context).checkInCardTitle,
                      size: 15.0.sp,
                      fontWeight: .w700,
                      color: AppColorManager.neutral900,
                    ),
                    2.0.verticalSpace,
                    DrawableText(
                      text: S.of(context).checkInCardHint,
                      size: 13.0.sp,
                      color: AppColorManager.neutral500,
                    ),
                  ],
                ),
              ),
            ],
          ),
          14.0.verticalSpace,
          MyButton(
            size: .medium,
            width: double.infinity,
            text: S.of(context).checkInScanButton,
            startIcon: ImageMultiType(
              url: Icons.qr_code_scanner_rounded,
              width: 18.0.r,
              height: 18.0.r,
              color: AppColorManager.neutral0,
            ),
            onTap: () async {
              await context.pushNamed(RouteName.checkIn, queryParameters: {RouteParam.id: meeting.id});
              // Refresh either way: the arrival may be recorded even if the user went back.
              if (context.mounted) context.read<MeetingCubit>().getData(newData: true);
            },
          ),
        ],
      ),
    );
  }
}
