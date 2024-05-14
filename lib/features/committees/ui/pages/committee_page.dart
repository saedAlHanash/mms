import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/circle_image_widget.dart';
import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/widgets/app_bar/app_bar_widget.dart';
import 'package:mms/core/widgets/my_card_widget.dart';
import 'package:mms/core/widgets/my_expansion/item_expansion.dart';
import 'package:mms/core/widgets/my_expansion/my_expansion_widget.dart';
import 'package:mms/features/committees/data/response/committees_response.dart';
import 'package:mms/features/goals/ui/widget/goals_list_widget.dart';
import 'package:mms/features/members/ui/widget/members_list_widget.dart';

import '../../../../core/util/my_style.dart';
import '../../../documents/ui/widget/documents_list_widget.dart';
import '../../bloc/committee_cubit/committee_cubit.dart';

class CommitteePage extends StatelessWidget {
  const CommitteePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: BlocBuilder<CommitteeCubit, CommitteeInitial>(
          builder: (context, state) {
            return DrawableText(
              fontWeight: FontWeight.bold,
              text: state.result.name,
              size: 24.0.sp,
              fontFamily: FontManager.cairoBold.name,
            );
          },
        ),
      ),
      body: BlocBuilder<CommitteeCubit, CommitteeInitial>(
        builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }

          final item = state.result;
          final members = item.members;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0).r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyCardWidget(
                  radios: 15.0.r,
                  child: DrawableText(
                    fontFamily: FontManager.cairoBold.name,
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
                  text: 'Description',
                  padding: const EdgeInsets.symmetric(horizontal: 15.0).w,
                ),
                DrawableText(
                  padding: const EdgeInsets.all(20.0).r,
                  color: Colors.grey,
                  text: item.description,
                  maxLines: 3,
                  matchParent: true,
                ),
                20.0.verticalSpace,
                DrawableText.title(
                  text: 'Statement',
                  padding: const EdgeInsets.symmetric(horizontal: 15.0).w,
                ),
                DrawableText(
                  padding: const EdgeInsets.all(20.0).r,
                  color: Colors.grey,
                  text: item.statement,
                  maxLines: 3,
                  matchParent: true,
                ),
                20.0.verticalSpace,
                DrawableText.title(
                  text: 'Members',
                  padding: const EdgeInsets.symmetric(horizontal: 15.0).w,
                ),
                MembersListWidget(members: members),
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
                GoalListWidget(goals: item.goals),
              ],
            ),
          );
        },
      ),
    );
  }
}
