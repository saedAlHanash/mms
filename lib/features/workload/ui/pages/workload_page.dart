import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/core/widgets/app_bar/app_bar_widget.dart';
import 'package:mms/core/widgets/empty_state_widget.dart';
import 'package:mms/core/widgets/initials_avatar.dart';
import 'package:mms/core/widgets/membership_badge.dart';
import 'package:mms/core/widgets/refresh_widget/refresh_widget.dart';
import 'package:mms/core/widgets/small_widgets.dart';
import 'package:mms/core/widgets/status_chip.dart';
import 'package:mms/features/workload/bloc/workload_cubit/workload_cubit.dart';
import 'package:mms/features/workload/data/response/workload_response.dart';
import 'package:mms/generated/l10n.dart';
import 'package:mms/router/go_router.dart';

/// A committee's workload: totals, then each member's open / overdue / due-soon tasks.
/// A plain member sees only their own row.
class WorkloadPage extends StatelessWidget {
  const WorkloadPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WorkloadCubit>();

    return Scaffold(
      appBar: AppBarWidget(titleText: S.of(context).workload),
      body: BlocBuilder<WorkloadCubit, WorkloadInitial>(
        buildWhen: (p, c) => p.result != c.result || p.statuses != c.statuses,
        builder: (context, state) {
          final data = state.result;
          final Widget body;

          if (state.loading && data.isEmpty) {
            body = ListView(
              padding: EdgeInsets.all(20.0.r),
              children: [
                const SkeletonBox(height: 84, radius: 14),
                16.0.verticalSpace,
                for (var i = 0; i < 4; i++) ...[const SkeletonBox(height: 92, radius: 14), 12.0.verticalSpace],
              ],
            );
          } else if (data.members.isEmpty) {
            body = ListView(
              padding: EdgeInsets.only(top: 80.0.h),
              children: [
                EmptyStateWidget.large(
                  icon: Icons.assignment_outlined,
                  title: state.statuses == CubitStatuses.error ? S.of(context).workloadUnavailable : S.of(context).noWorkload,
                  description: state.statuses == CubitStatuses.error ? state.error : S.of(context).noWorkloadDescription,
                ),
              ],
            );
          } else {
            body = ListView(
              padding: EdgeInsets.fromLTRB(20.0.w, 16.0.h, 20.0.w, 32.0.h),
              children: [
                if (!data.onlyMine) ...[
                  _Totals(data: data),
                  20.0.verticalSpace,
                  SectionHeader(title: S.of(context).members, trailing: S.of(context).membersCount(data.members.length)),
                  10.0.verticalSpace,
                ],
                for (final row in data.members) ...[
                  _RowCard(row: row, onTap: () => _TasksSheet.show(context, cubit: cubit, row: row)),
                  12.0.verticalSpace,
                ],
              ],
            );
          }

          return RefreshWidget(isLoading: state.loading, onRefresh: cubit.getData, child: body);
        },
      ),
    );
  }
}

class _Totals extends StatelessWidget {
  const _Totals({required this.data});

  final Workload data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.0.h),
      decoration: BoxDecoration(
        color: AppColorManager.neutral0,
        borderRadius: BorderRadius.circular(14.0.r),
        border: Border.all(color: AppColorManager.neutral100),
      ),
      child: Row(
        children: [
          _Figure(value: data.openTasks, label: S.of(context).workloadOpen, color: AppColorManager.neutral900),
          _Figure(value: data.overdueTasks, label: S.of(context).workloadOverdue, color: AppColorManager.dangerText),
          _Figure(value: data.unassigned, label: S.of(context).workloadUnassigned, color: AppColorManager.neutral500),
        ],
      ),
    );
  }
}

class _Figure extends StatelessWidget {
  const _Figure({required this.value, required this.label, required this.color});

  final int value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          DrawableText(text: '$value', size: 22.0.sp, fontWeight: .w700, color: value == 0 ? AppColorManager.neutral500 : color),
          2.0.verticalSpace,
          DrawableText(text: label, size: 12.0.sp, color: AppColorManager.neutral500, textAlign: .center),
        ],
      ),
    );
  }
}

class _RowCard extends StatelessWidget {
  const _RowCard({required this.row, required this.onTap});

  final WorkloadRow row;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final radius = BorderRadius.circular(14.0.r);

    return Material(
      color: AppColorManager.neutral0,
      borderRadius: radius,
      child: InkWell(
        borderRadius: radius,
        onTap: onTap,
        child: Ink(
          padding: EdgeInsets.all(14.0.r),
          decoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(color: row.overdue > 0 ? AppColorManager.dangerSoft : AppColorManager.neutral100),
          ),
          child: Column(
            crossAxisAlignment: .stretch,
            children: [
              Row(
                children: [
                  InitialsAvatar(name: row.name, size: 40),
                  10.0.horizontalSpace,
                  Expanded(
                    child: DrawableText(
                      text: row.isMe ? '${row.name} (${s.you})' : row.name,
                      size: 15.0.sp,
                      fontWeight: .w700,
                      color: AppColorManager.neutral900,
                      maxLines: 1,
                    ),
                  ),
                  MembershipBadge(type: row.membershipType),
                ],
              ),
              12.0.verticalSpace,
              Wrap(
                spacing: 6.0.w,
                runSpacing: 6.0.h,
                children: [
                  _Count(label: s.workloadOpenCount(row.open), tone: _Tone.neutral),
                  if (row.overdue > 0) _Count(label: s.workloadOverdueCount(row.overdue), tone: _Tone.danger),
                  if (row.dueSoon > 0) _Count(label: s.workloadDueSoonCount(row.dueSoon), tone: _Tone.warning),
                  _Count(label: s.workloadDoneCount(row.completedThisYear), tone: _Tone.success),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum _Tone { neutral, danger, warning, success }

class _Count extends StatelessWidget {
  const _Count({required this.label, required this.tone});

  final String label;
  final _Tone tone;

  @override
  Widget build(BuildContext context) {
    final colors = switch (tone) {
      _Tone.neutral => const StatusColors(dot: AppColorManager.neutral500, bg: AppColorManager.neutral50, fg: AppColorManager.neutral700),
      _Tone.danger => const StatusColors(dot: AppColorManager.danger, bg: AppColorManager.dangerSoft, fg: AppColorManager.dangerText),
      _Tone.warning => const StatusColors(dot: AppColorManager.warning, bg: AppColorManager.warningSoft, fg: AppColorManager.warningText),
      _Tone.success => const StatusColors(dot: AppColorManager.success, bg: AppColorManager.successSoft, fg: AppColorManager.successText),
    };
    return StatusChip(colors: colors, label: label);
  }
}

/// One member's tasks; tapping one opens its meeting.
class _TasksSheet extends StatelessWidget {
  const _TasksSheet({required this.row});

  final WorkloadRow row;

  static Future<void> show(BuildContext context, {required WorkloadCubit cubit, required WorkloadRow row}) {
    cubit.getTasks(row.partyId);
    return AppBottomSheet.show(context, child: BlocProvider.value(value: cubit, child: _TasksSheet(row: row)));
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.75),
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .stretch,
        children: [
          DrawableText(
            text: row.isMe ? S.of(context).myTasks : S.of(context).tasksOf(row.name),
            size: 17.0.sp,
            fontWeight: .w700,
            color: AppColorManager.neutral900,
          ),
          12.0.verticalSpace,
          Flexible(
            child: BlocBuilder<WorkloadCubit, WorkloadInitial>(
              builder: (context, state) {
                if (state.tasksLoading) {
                  return Column(
                    mainAxisSize: .min,
                    children: [for (var i = 0; i < 3; i++) ...[const SkeletonBox(height: 64, radius: 12), 8.0.verticalSpace]],
                  );
                }
                if (state.tasks.isEmpty) {
                  return EmptyStateWidget.inline(
                    icon: Icons.task_alt_rounded,
                    title: state.tasksError.isNotEmpty ? state.tasksError : S.of(context).noTasks,
                  );
                }
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: state.tasks.length,
                  separatorBuilder: (_, _) => 8.0.verticalSpace,
                  itemBuilder: (context, i) => _TaskTile(task: state.tasks[i]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskTile extends StatelessWidget {
  const _TaskTile({required this.task});

  final WorkloadTask task;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(12.0.r);
    final canOpen = task.meetingId.isNotEmpty;

    return Material(
      color: AppColorManager.neutral0,
      borderRadius: radius,
      child: InkWell(
        borderRadius: radius,
        onTap: canOpen
            ? () {
                Navigator.pop(context);
                context.pushNamed(RouteName.meeting, queryParameters: {RouteParam.id: task.meetingId});
              }
            : null,
        child: Ink(
          padding: EdgeInsets.all(12.0.r),
          decoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(color: task.overdue ? AppColorManager.dangerSoft : AppColorManager.neutral100),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    DrawableText(
                      text: task.code.isEmpty ? task.name : '${task.code} · ${task.name}',
                      size: 14.0.sp,
                      fontWeight: .w600,
                      color: AppColorManager.neutral900,
                      maxLines: 2,
                    ),
                    if (task.dueDate case final due?) ...[
                      4.0.verticalSpace,
                      DrawableText(
                        text: S.of(context).dueOn(due.formatDate),
                        size: 12.0.sp,
                        fontWeight: task.overdue ? .w700 : .w400,
                        color: task.overdue ? AppColorManager.dangerText : AppColorManager.neutral500,
                      ),
                    ],
                  ],
                ),
              ),
              8.0.horizontalSpace,
              StatusChip(colors: task.status.colors, label: task.status.label),
              if (canOpen) ...[
                4.0.horizontalSpace,
                ImageMultiType(
                  url: Directionality.of(context) == .rtl ? Icons.chevron_left_rounded : Icons.chevron_right_rounded,
                  width: 20.0.r,
                  height: 20.0.r,
                  color: AppColorManager.neutral500,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
