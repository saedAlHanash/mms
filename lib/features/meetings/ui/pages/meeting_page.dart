import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/widgets/app_bar/app_bar_widget.dart';
import 'package:mms/core/widgets/my_card_widget.dart';
import 'package:mms/features/attendees/ui/widget/attendees_list_widget.dart';
import 'package:mms/features/committees/ui/widget/drawer_btn_widget.dart';
import 'package:mms/features/meetings/ui/widget/absent_widget.dart';

import '../../../../core/util/my_style.dart';
import '../../../../generated/l10n.dart';
import '../../bloc/add_absence_cubit/add_absence_cubit.dart';
import '../../bloc/meeting_cubit/meeting_cubit.dart';

class MeetingPage extends StatelessWidget {
  const MeetingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MeetingCubit, MeetingInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            AppProvider.setMeeting = state.result;
          },
        ),
        BlocListener<AddAbsenceCubit, AddAbsenceInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            context.read<MeetingCubit>().getMeeting(newData: true);
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBarWidget(
          titleText: S.of(context).meeting,
          actions: [
            0.0.verticalSpace,
          ],
        ),
        endDrawer: Drawer(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          child: BlocBuilder<MeetingCubit, MeetingInitial>(
            builder: (context, state) {
              return AttendeesListWidget(attendees: state.result.attendeesList);
            },
          ),
        ),
        body: BlocBuilder<MeetingCubit, MeetingInitial>(
          builder: (context, state) {
            if (state.statuses.loading) {
              return MyStyle.loadingWidget();
            }
            final item = state.result;

            return Stack(
              children: [
                RefreshIndicator(
                  onRefresh: () async {
                    context.read<MeetingCubit>().getMeeting(newData: true);
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0).r,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyCardWidget(
                          radios: 15.0.r,
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DrawableText(
                                    fontFamily: FontManager.cairoBold.name,
                                    size: 20.0.sp,
                                    text: item.title,
                                  ),
                                  5.0.verticalSpace,
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
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  DrawableText(
                                    drawableEnd: ImageMultiType(
                                      url: Icons.not_started_rounded,
                                      height: 17.0.r,
                                      width: 17.0.r,
                                      color: Colors.green,
                                    ),
                                    drawablePadding: 10.0.w,
                                    text: item.fromDate?.formatDateTime ?? '',
                                  ),
                                  20.0.verticalSpace,
                                  DrawableText(
                                    drawableEnd: ImageMultiType(
                                      url: Icons.edit_calendar,
                                      color: Colors.amber,
                                      height: 17.0.r,
                                      width: 17.0.r,
                                    ),
                                    drawablePadding: 10.0.w,
                                    text: item.toDate?.formatDateTime ?? '',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        50.0.verticalSpace,
                        AbsentWidget(),
                        20.0.verticalSpace,
                        DrawableText.title(
                          text: 'Goals',
                          padding:
                              const EdgeInsets.symmetric(horizontal: 15.0).w,
                        ),
                        100.0.verticalSpace,
                        // GoalListWidget(goals: item.goals),
                      ],
                    ),
                  ),
                ),
                const DrawerMemberBtnWidget(),
              ],
            );
          },
        ),
      ),
    );
  }
}
