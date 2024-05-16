import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/widgets/my_expansion/item_expansion.dart';
import '../../../../core/widgets/my_expansion/my_expansion_widget.dart';
import '../../../../generated/assets.dart';
import '../../../committees/data/response/committees_response.dart';
import '../../data/response/goals_response.dart';

class GoalListWidget extends StatelessWidget {
  const GoalListWidget({super.key, required this.goals});

  final List<Goal> goals;

  @override
  Widget build(BuildContext context) {
    return MyExpansionWidget(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0.r),
          color: AppColorManager.f9),
      items: goals
          .map(
            (e) => ItemExpansion(
              header: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DrawableText(
                      matchParent: true,
                      text: e.name,
                      fontFamily: FontManager.cairoBold.name,
                      size: 20.0.sp,
                      maxLines: 1,
                    ),
                    DrawableText(
                      matchParent: true,
                      text: e.description,
                      color: Colors.black87,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              body: Column(
                children: e.tasks.map((e) => _TaskWidget(task: e)).toList(),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _TaskWidget extends StatelessWidget {
  const _TaskWidget({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: EdgeInsetsDirectional.only(start: 30.0.w, bottom: 10.0.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0.r),
          color: AppColorManager.f9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 0.6.sw,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DrawableText(
                  text: task.name,
                  fontFamily: FontManager.cairoBold.name,
                  size: 20.0.sp,
                  maxLines: 2,
                ),
                10.0.verticalSpace,
                DrawableText(
                  text: task.description,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
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
                text: task.startDate?.formatDate ?? '',
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
                text: task.dueDate?.formatDate ?? '',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
