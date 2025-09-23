import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/util/snack_bar_message.dart';
import 'package:mms/core/widgets/app_bar/app_bar_widget.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/core/widgets/my_card_widget.dart';
import 'package:mms/core/widgets/refresh_widget/refresh_widget.dart';
import 'package:mms/features/agendas/ui/widget/agenda_tree_widget.dart';
import 'package:mms/features/agora/bloc/agora_cubit/agora_cubit.dart';
import 'package:mms/features/agora/ui/widget/agora_header.dart';
import 'package:mms/features/attendees/ui/widget/attendees_list_widget.dart';
import 'package:mms/features/committees/ui/widget/drawer_btn_widget.dart';
import 'package:mms/features/agora/ui/pages/call_page.dart';
import 'package:mms/features/meetings/ui/widget/absent_widget.dart';
import 'package:mms/features/meetings/ui/widget/discussions_tree.dart';
import 'package:mms/services/ui_helper.dart';

import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
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
            context.read<MeetingCubit>().getData(newData: true);
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBarWidget(
          titleText: S.of(context).meeting,
          actions: const [
            ActionBarMemberWidget(),
          ],
        ),
        endDrawer: Drawer(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          child: BlocBuilder<MeetingCubit, MeetingInitial>(
            builder: (context, state) {
              return AttendeesListWidget(meeting: state.result);
            },
          ),
        ),
        bottomNavigationBar: HeaderSheet(
          onTap: () {
            NoteMessage.showBottomSheet1(
              child: BlocProvider.value(
                value: context.read<AgoraCubit>(),
                child: CallPage(),
              ),
            );
          },
        ),
        body: BlocBuilder<MeetingCubit, MeetingInitial>(
          builder: (context, state) {
            final item = state.result;
            return RefreshWidget(
              onRefresh: () => context.read<MeetingCubit>().getData(newData: true),
              statuses: state.statuses,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0).r,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyCardWidget(
                      radios: 15.0.r,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DrawableText(
                            matchParent: true,
                            fontWeight: FontWeight.bold,
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
                          10.0.verticalSpace,
                          Row(
                            children: [
                              DrawableText(
                                drawableStart: ImageMultiType(
                                  url: Icons.not_started_rounded,
                                  height: 24.0.r,
                                  width: 24.0.r,
                                  color: Colors.green,
                                ),
                                drawablePadding: 10.0.w,
                                text: item.fromDate?.formatDateTime ?? '',
                              ),
                              const Spacer(),
                              DrawableText(
                                drawableStart: ImageMultiType(
                                  url: Icons.edit_calendar,
                                  color: Colors.black,
                                  height: 24.0.r,
                                  width: 24.0.r,
                                ),
                                drawablePadding: 10.0.w,
                                text: item.toDate?.formatDateTime ?? '',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const AbsentWidget(),
                    20.0.verticalSpace,
                    ListTile(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0.r)),
                      tileColor: AppColorManager.mainColor.withValues(alpha: 0.2),
                      onTap: () {
                        Navigator.pushNamed(context, RouteName.votes, arguments: context.read<MeetingCubit>());
                      },
                      title: DrawableText(
                        text: S.of(context).votes,
                        size: 20.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      trailing: state.result.countPollsNotVotes == 0
                          ? ImageMultiType(url: Icons.arrow_forward_ios, color: Colors.grey, width: 17.0.sp)
                          : Row(
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                  ),
                                  padding: const EdgeInsets.all(7.0).r,
                                  child: DrawableText(
                                    text: state.result.countPollsNotVotes.toString(),
                                    color: Colors.white,
                                  ),
                                ),
                                5.0.horizontalSpace,
                                ImageMultiType(url: Icons.arrow_forward_ios, color: Colors.grey, width: 17.0.sp)
                              ],
                            ),
                      leading: ImageMultiType(url: Icons.how_to_vote),
                    ),
                    20.0.verticalSpace,
                    AgendaTreeWidget(
                      treeNode: state.getAgendaTree(),
                    ),
                    20.0.verticalSpace,
                    if (state.result.discussions.isNotEmpty) DiscussionsTree(treeNode: state.getDiscussionTree()),
                    100.0.verticalSpace,
                    // GoalListWidget(goals: item.goals),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
