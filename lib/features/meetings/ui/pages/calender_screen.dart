import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/widgets/app_bar/app_bar_widget.dart';
import 'package:mms/core/widgets/empty_state_widget.dart';
import 'package:mms/features/committees/ui/widget/meetings_calendar.dart';
import 'package:mms/features/home/ui/widget/bottom_nav_widget.dart';
import 'package:mms/features/meetings/data/response/meetings_response.dart';
import 'package:mms/features/meetings/ui/widget/meeting_item.dart';
import 'package:mms/generated/l10n.dart';

/// Home "Calendar" tab.
class CalenderScreen extends StatelessWidget {
  const CalenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 64.0.h,
          alignment: AlignmentDirectional.centerStart,
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: DrawableText(
            text: S.of(context).navCalendar,
            size: 22.0.sp,
            fontWeight: .w700,
            color: AppColorManager.neutral900,
          ),
        ),
        Expanded(
          child: MeetingCalenderWidget(
            builder: (ctx, list, widget) => MeetingsDayList(list: list, bottomPadding: homeNavBarSpace),
          ),
        ),
      ],
    );
  }
}

/// Committee meetings calendar (opened from a committee page).
class CalenderMeetingPage extends StatelessWidget {
  const CalenderMeetingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(titleText: 'Meetings'),
      body: MeetingCalenderWidget(
        builder: (ctx, list, widget) => MeetingsDayList(list: list),
      ),
    );
  }
}

/// Meetings of the selected day, or a dashed empty state.
class MeetingsDayList extends StatelessWidget {
  const MeetingsDayList({
    super.key,
    required this.list,
    this.showCommittee = true,
    this.bottomPadding,
  });

  final List<Meeting> list;
  final bool showCommittee;
  final double? bottomPadding;

  @override
  Widget build(BuildContext context) {
    final bottom = bottomPadding ?? 24.0.h;

    if (list.isEmpty) {
      return Expanded(
        child: ListView(
          padding: EdgeInsets.fromLTRB(20.0.w, 6.0.h, 20.0.w, bottom),
          children: [
            EmptyStateWidget.inline(
              icon: Icons.event_busy_outlined,
              title: S.of(context).noMeetingsThisDay,
              description: S.of(context).noMeetingsThisDayHint,
            ),
          ],
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(top: 2.0.h, bottom: bottom),
        itemCount: list.length,
        itemBuilder: (context, i) => ItemMeeting(item: list[i], showCommittee: showCommittee),
      ),
    );
  }
}
