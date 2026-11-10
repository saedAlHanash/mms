import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/widgets/empty_state_widget.dart';
import 'package:mms/core/widgets/icon_tile.dart';
import 'package:mms/features/goals/data/response/goals_response.dart';
import 'package:mms/generated/l10n.dart';

/// Committee goals: one collapsible card per goal with its tasks.
/// The first goal is open by default.
class GoalListWidget extends StatelessWidget {
  const GoalListWidget({super.key, required this.goals});

  final List<Goal> goals;

  @override
  Widget build(BuildContext context) {
    if (goals.isEmpty) {
      return EmptyStateWidget.inline(
        icon: Icons.flag_outlined,
        title: S.of(context).noGoalsYet,
        description: S.of(context).noGoalsYetDescription,
      );
    }

    return Column(
      children: [
        for (var i = 0; i < goals.length; i++) ...[
          if (i > 0) 12.0.verticalSpace,
          _GoalCard(goal: goals[i], initiallyOpen: i == 0),
        ],
      ],
    );
  }
}

class _GoalCard extends StatefulWidget {
  const _GoalCard({required this.goal, required this.initiallyOpen});

  final Goal goal;
  final bool initiallyOpen;

  @override
  State<_GoalCard> createState() => _GoalCardState();
}

class _GoalCardState extends State<_GoalCard> {
  late bool _open = widget.initiallyOpen;

  @override
  Widget build(BuildContext context) {
    final goal = widget.goal;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColorManager.neutral0,
        border: Border.all(color: AppColorManager.neutral100),
        borderRadius: BorderRadius.circular(12.0.r),
      ),
      child: Column(
        children: [
          Semantics(
            button: true,
            expanded: _open,
            child: InkWell(
              onTap: () => setState(() => _open = !_open),
              child: Container(
                constraints: BoxConstraints(minHeight: 60.0.h),
                padding: EdgeInsets.symmetric(horizontal: 14.0.w, vertical: 8.0.h),
                child: Row(
                  children: [
                    const IconTile(icon: Icons.flag_outlined, size: 36, iconSize: 20),
                    12.0.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        mainAxisSize: .min,
                        children: [
                          DrawableText(
                            text: goal.name,
                            size: 15.0.sp,
                            fontWeight: .w700,
                            color: AppColorManager.neutral900,
                          ),
                          DrawableText(
                            text: S.of(context).tasksCount(goal.tasks.length),
                            size: 13.0.sp,
                            color: AppColorManager.neutral500,
                          ),
                        ],
                      ),
                    ),
                    AnimatedRotation(
                      turns: _open ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: ImageMultiType(
                        url: Icons.keyboard_arrow_down_rounded,
                        width: 22.0.r,
                        height: 22.0.r,
                        color: AppColorManager.neutral500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            alignment: AlignmentDirectional.topCenter,
            child: !_open || goal.tasks.isEmpty
                ? const SizedBox(width: double.infinity)
                : Container(
                    decoration: const BoxDecoration(
                      border: Border(top: BorderSide(color: AppColorManager.neutral50)),
                    ),
                    child: Column(
                      children: [
                        for (var i = 0; i < goal.tasks.length; i++) ...[
                          if (i > 0)
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 14.0.w),
                              child: const Divider(height: 1, color: AppColorManager.neutral50),
                            ),
                          _TaskWidget(task: goal.tasks[i]),
                        ],
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _TaskWidget extends StatelessWidget {
  const _TaskWidget({required this.task});

  final Task task;

  Widget _date(BuildContext context, String label, IconData icon, Color iconColor, DateTime? date) {
    return Column(
      crossAxisAlignment: .start,
      mainAxisSize: .min,
      children: [
        DrawableText(text: label, size: 12.0.sp, color: AppColorManager.neutral500),
        Row(
          mainAxisSize: .min,
          children: [
            ImageMultiType(url: icon, width: 15.0.r, height: 15.0.r, color: iconColor),
            6.0.horizontalSpace,
            Directionality(
              textDirection: .ltr,
              child: DrawableText(
                text: date?.formatDate ?? '—',
                size: 13.0.sp,
                fontWeight: .w600,
                color: AppColorManager.neutral900,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.0.w, vertical: 12.0.h),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          DrawableText(
            text: task.name,
            size: 15.0.sp,
            fontWeight: .w600,
            color: AppColorManager.neutral900,
            matchParent: true,
          ),
          if (task.description.isNotEmpty) ...[
            4.0.verticalSpace,
            DrawableText(
              text: task.description,
              size: 13.0.sp,
              color: AppColorManager.neutral500,
              matchParent: true,
            ),
          ],
          8.0.verticalSpace,
          Row(
            crossAxisAlignment: .start,
            children: [
              Expanded(
                child: _date(
                  context,
                  S.of(context).startDate,
                  Icons.not_started_rounded,
                  AppColorManager.success,
                  task.startDate,
                ),
              ),
              12.0.horizontalSpace,
              Expanded(
                child: _date(
                  context,
                  S.of(context).dueDate,
                  Icons.edit_calendar,
                  AppColorManager.warning,
                  task.dueDate,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
