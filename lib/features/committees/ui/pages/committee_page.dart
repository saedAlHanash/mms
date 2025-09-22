import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/widgets/app_bar/app_bar_widget.dart';
import 'package:mms/core/widgets/my_card_widget.dart';
import 'package:mms/core/widgets/refresh_widget/refresh_widget.dart';
import 'package:mms/features/committees/ui/widget/drawer_btn_widget.dart';
import 'package:mms/features/goals/ui/widget/goals_list_widget.dart';
import 'package:mms/features/members/ui/widget/members_list_widget.dart';

import '../../../../generated/l10n.dart';
import '../../../documents/ui/widget/documents_list_widget.dart';
import '../../bloc/committee_cubit/committee_cubit.dart';
import '../widget/meetings_btn_widget.dart';

class CommitteePage extends StatelessWidget {
  const CommitteePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        actions: [0.0.verticalSpace],
        title: BlocBuilder<CommitteeCubit, CommitteeInitial>(
          builder: (context, state) {
            return DrawableText(
              fontWeight: FontWeight.bold,
              text: state.result.name,
              size: 24.0.sp,
            );
          },
        ),
      ),
      endDrawer: Drawer(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        child: BlocBuilder<CommitteeCubit, CommitteeInitial>(
          builder: (context, state) {
            return MembersListWidget(members: state.result.members);
          },
        ),
      ),
      body: BlocBuilder<CommitteeCubit, CommitteeInitial>(
        builder: (context, state) {
          final item = state.result;
          return Stack(
            children: [
              RefreshWidget(
                statuses: state.statuses,
                onRefresh: () {
                  context.read<CommitteeCubit>().getData(newData: true);
                },
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0).r,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyCardWidget(
                        radios: 15.0.r,
                        child: DrawableText(
                          fontWeight: FontWeight.bold,
                          size: 18.0.sp,
                          text: item.name,
                          matchParent: true,
                          drawableEnd: DrawableText(
                            size: 18.0.sp,
                            text: item.formationDate?.formatDate ?? '',
                          ),
                        ),
                      ),
                      20.0.verticalSpace,
                      DrawableText.title(
                        text: S.of(context).description,
                        padding: const EdgeInsets.symmetric(horizontal: 15.0).w,
                      ),
                      SizedBox(
                        width: 0.8.sw,
                        child: DrawableText(
                          padding: const EdgeInsets.all(20.0).r,
                          color: Colors.grey,
                          text: item.description,
                          maxLines: 3,
                          matchParent: true,
                        ),
                      ),
                      20.0.verticalSpace,
                      DrawableText.title(
                        text: S.of(context).statement,
                        padding: const EdgeInsets.symmetric(horizontal: 15.0).w,
                      ),
                      DrawableText(
                        padding: const EdgeInsets.all(20.0).r,
                        color: Colors.grey,
                        text: item.statement,
                        maxLines: 3,
                        matchParent: true,
                      ),
                      30.0.verticalSpace,
                      DrawableText.title(
                        text: S.of(context).documents,
                        padding: const EdgeInsets.symmetric(horizontal: 15.0).w,
                      ),
                      10.0.verticalSpace,
                      DocumentsListWidget(documents: item.documents),
                      20.0.verticalSpace,
                      GoalListWidget(goals: state.getTree()),
                      20.0.verticalSpace,
                    ],
                  ),
                ),
              ),
              const DrawerMemberBtnWidget(),
              const DrawerMeetingsBtnWidget(),
            ],
          );
        },
      ),
    );
  }
}
