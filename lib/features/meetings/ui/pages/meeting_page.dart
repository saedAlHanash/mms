import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/widgets/app_bar/app_bar_widget.dart';
import 'package:mms/core/widgets/my_card_widget.dart';
import 'package:mms/features/attendees/ui/widget/attendees_list_widget.dart';
import 'package:mms/features/committees/ui/widget/drawer_btn_widget.dart';

import '../../../../core/util/my_style.dart';
import '../../../../generated/assets.dart';
import '../../../documents/ui/widget/documents_list_widget.dart';
import '../../bloc/meeting_cubit/meeting_cubit.dart';

class MeetingPage extends StatelessWidget {
  const MeetingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBarWidget(
        titleText: 'Meeting',
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
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0).r,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyCardWidget(
                      radios: 15.0.r,
                      child: Column(
                        children: [
                          DrawableText(
                            matchParent: true,
                            fontFamily: FontManager.cairoBold.name,
                            size: 20.0.sp,
                            text: item.title,
                          ),
                          5.0.verticalSpace,
                          DrawableText(
                            matchParent: true,
                            text: item.meetingPlace,
                            drawableStart: ImageMultiType(
                              url: Icons.place,
                              height: 15.0.r,
                              width: 15.0.r,
                            ),
                          ),
                        ],
                      ),
                    ),
                    20.0.verticalSpace,
                    DrawableText.title(
                      text: 'Description',
                      padding: const EdgeInsets.symmetric(horizontal: 15.0).w,
                    ),
                    DrawableText(
                      padding: const EdgeInsets.all(20.0).r,
                      color: Colors.grey,
                      text: item.meetingPlace,
                    ),
                    20.0.verticalSpace,

                    30.0.verticalSpace,
                    DrawableText.title(
                      text: 'Documents',
                      padding: const EdgeInsets.symmetric(horizontal: 15.0).w,
                    ),
                    10.0.verticalSpace,
                    DocumentsListWidget(documents: item.documents),
                    20.0.verticalSpace,
                    DrawableText.title(
                      text: 'Goals',
                      padding: const EdgeInsets.symmetric(horizontal: 15.0).w,
                    ),
                    // GoalListWidget(goals: item.goals),
                  ],
                ),
              ),
              DrawerMemberBtnWidget(),
            ],
          );
        },
      ),
    );
  }
}
