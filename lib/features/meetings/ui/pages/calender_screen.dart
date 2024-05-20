import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/widgets/app_bar/app_bar_widget.dart';
import 'package:mms/features/committees/ui/widget/meetings_calendar.dart';
import 'package:mms/features/meetings/bloc/meetings_cubit/meetings_cubit.dart';
import 'package:mms/features/meetings/ui/widget/meeting_item.dart';

import '../../../../generated/assets.dart';

class CalenderScreen extends StatelessWidget {
  const CalenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MeetingCalenderWidget(
      doteColor: AppColorManager.red,
      builder: (ctx, list, widget) {
        return Expanded(
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, i) {
              final e = list[i];
              return ItemMeeting(item: e);
            },
          ),
        );
      },
    );
  }
}

class CalenderMeetingPage extends StatelessWidget {
  const CalenderMeetingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(titleText: 'Meetings'),
      body: MeetingCalenderWidget(
        doteColor: AppColorManager.red,
        builder: (ctx, list, widget) {
          return Expanded(
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, i) {
                final e = list[i];
                return ItemMeeting(item: e);
              },
            ),
          );
        },
      ),
    );
  }
}
