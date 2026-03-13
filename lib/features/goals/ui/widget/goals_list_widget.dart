import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/widgets/expansion/tree_widget.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../../generated/l10n.dart';
import '../../data/response/goals_response.dart';

class GoalListWidget extends StatelessWidget {
  const GoalListWidget({super.key, required this.goals});

  final TreeNode<Goal> goals;

  @override
  Widget build(BuildContext context) {
    return TreeWidget(
      treeNode: goals,
      builder: (node) {
        if (node.isRoot) {
          return MyCardWidget(
            padding: const EdgeInsets.all(30.0).r,
            child: DrawableText(
              fontWeight: FontWeight.bold,
              size: 18.0.sp,
              text: '${S.of(context).goals} (${node.length})',
              matchParent: true,
            ),
          );
        }
        final goal = node.data!;

        return TreeWidget(
          treeNode: TreeNode<Task>.root(data: Task.fromJson({}))
            ..addAll(goal.tasks.map(
              (e) => TreeNode(data: e),
            )),
          builder: (node) {
            if (node.isRoot) {
              return MyCardWidget(
                padding: const EdgeInsets.all(30.0).r,
                child: DrawableText(
                  fontWeight: FontWeight.bold,
                  size: 18.0.sp,
                  text: goal.name,
                  matchParent: true,
                ),
              );
            }
            final e = node.data!;
            return _TaskWidget(task: e);
          },
        );
      },
    );
    // return MyExpansionWidget(
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(8.0.r),
    //     color: AppColorManager.f9,
    //   ),
    //   margin: const EdgeInsets.symmetric(vertical: 10.0).r,
    //   items: goals
    //       .map(
    //         (e) => ItemExpansion(
    //           header: ListTile(
    //             title: DrawableText(
    //               matchParent: true,
    //               text: e.name,
    //              fontWeight: FontWeight.bold,
    //               size: 20.0.sp,
    //               maxLines: 1,
    //             ),
    //             subtitle: DrawableText(
    //               matchParent: true,
    //               text: e.description,
    //               color: Colors.black87,
    //               maxLines: 1,
    //             ),
    //           ),
    //           body: Column(
    //             children: e.tasks.mapIndexed((i, e) {
    //               if (i == 0) {
    //                 return Column(
    //                   children: [
    //                     10.0.verticalSpace,
    //                     _TaskWidget(task: e),
    //                   ],
    //                 );
    //               }
    //               return _TaskWidget(task: e);
    //             }).toList(),
    //           ),
    //         ),
    //       )
    //       .toList(),
    // );
  }
}

class _TaskWidget extends StatelessWidget {
  const _TaskWidget({required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: EdgeInsetsDirectional.only(start: 30.0.w, bottom: 10.0.h),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0.r), color: AppColorManager.f9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DrawableText(
                  text: task.name,
                  fontWeight: FontWeight.bold,
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
