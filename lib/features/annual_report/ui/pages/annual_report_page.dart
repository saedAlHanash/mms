import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/core/widgets/app_bar/app_bar_widget.dart';
import 'package:mms/core/widgets/empty_state_widget.dart';
import 'package:mms/core/widgets/my_card_widget.dart';
import 'package:mms/core/widgets/refresh_widget/refresh_widget.dart';
import 'package:mms/core/widgets/small_widgets.dart';
import 'package:mms/core/widgets/status_chip.dart';
import 'package:mms/core/widgets/year_switcher.dart';
import 'package:mms/features/annual_report/bloc/annual_report_cubit/annual_report_cubit.dart';
import 'package:mms/features/annual_report/data/response/annual_report_response.dart';
import 'package:mms/generated/l10n.dart';
import 'package:mms/router/go_router.dart';

/// The committee's year for the chair and the secretary: meetings, attendance,
/// decisions and how far they are carried out, tasks and circulations.
class AnnualReportPage extends StatelessWidget {
  const AnnualReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final cubit = context.read<AnnualReportCubit>();

    return Scaffold(
      appBar: AppBarWidget(titleText: s.committeeReport),
      body: BlocBuilder<AnnualReportCubit, AnnualReportInitial>(
        builder: (context, state) {
          final data = state.result;
          final Widget content;

          if (state.loading && data.isEmpty) {
            content = Column(
              children: [
                const SkeletonBox(height: 220, radius: 14),
                16.0.verticalSpace,
                for (var i = 0; i < 3; i++) ...[const SkeletonBox(height: 76, radius: 14), 12.0.verticalSpace],
              ],
            );
          } else if (data.isEmpty) {
            content = Padding(
              padding: EdgeInsets.only(top: 60.0.h),
              child: EmptyStateWidget.large(
                icon: Icons.insights_outlined,
                title: s.reportUnavailable,
                description: state.statuses == CubitStatuses.error ? state.error : null,
              ),
            );
          } else {
            content = Column(
              crossAxisAlignment: .stretch,
              children: [
                _Summary(summary: data.summary),
                if (data.decisions.isNotEmpty) ...[
                  20.0.verticalSpace,
                  SectionHeader(title: s.decisions, trailing: '${data.decisions.length}'),
                  10.0.verticalSpace,
                  for (final d in data.decisions) ...[_DecisionRow(decision: d), 10.0.verticalSpace],
                ],
                if (data.meetings.isNotEmpty) ...[
                  20.0.verticalSpace,
                  SectionHeader(title: s.meetings, trailing: '${data.meetings.length}'),
                  10.0.verticalSpace,
                  for (final m in data.meetings) ...[_MeetingRow(meeting: m), 10.0.verticalSpace],
                ],
                if (data.circulations.isNotEmpty) ...[
                  20.0.verticalSpace,
                  SectionHeader(title: s.circulations, trailing: '${data.circulations.length}'),
                  10.0.verticalSpace,
                  for (final c in data.circulations) ...[_CirculationRow(circulation: c), 10.0.verticalSpace],
                ],
                if (data.generatedAt != null) ...[
                  12.0.verticalSpace,
                  DrawableText(
                    text: s.reportGeneratedAt(data.generatedAt!.formatDateTime),
                    size: 12.0.sp,
                    color: AppColorManager.neutral500,
                    textAlign: .center,
                  ),
                ],
              ],
            );
          }

          return RefreshWidget(
            isLoading: state.loading,
            onRefresh: cubit.getData,
            child: ListView(
              padding: EdgeInsets.fromLTRB(20.0.w, 12.0.h, 20.0.w, 32.0.h),
              children: [
                YearSwitcher(year: state.year, onChange: (y) => cubit.getData(year: y)),
                12.0.verticalSpace,
                content,
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Summary extends StatelessWidget {
  const _Summary({required this.summary});

  final AnnualSummary summary;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    String pct(int? v) => v == null ? '–' : '$v%';
    final min = summary.minMeetings;

    return MyCardWidget(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.all(16.0.r),
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          Row(
            children: [
              _Figure(
                value: min == null ? '${summary.meetingsHeld}' : '${summary.meetingsHeld}/$min',
                label: s.meetingsHeld,
              ),
              _Figure(value: '${summary.meetingsScheduled}', label: s.meetingsScheduledLabel),
              _Figure(value: pct(summary.attendanceRate), label: s.attendanceRate),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Divider(height: 1, color: AppColorManager.neutral100),
          ),
          Row(
            children: [
              _Figure(value: '${summary.decisions}', label: s.decisions),
              _Figure(value: pct(summary.executionRate), label: s.executionRate),
              _Figure(
                value: '${summary.decisionsOverdue}',
                label: s.decisionsOverdue,
                color: summary.decisionsOverdue > 0 ? AppColorManager.dangerText : null,
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Divider(height: 1, color: AppColorManager.neutral100),
          ),
          Row(
            children: [
              _Figure(value: '${summary.openTasks}', label: s.workloadOpen),
              _Figure(
                value: '${summary.overdueTasks}',
                label: s.workloadOverdue,
                color: summary.overdueTasks > 0 ? AppColorManager.dangerText : null,
              ),
              _Figure(value: '${summary.circulationsApproved}', label: s.circulationsApprovedLabel),
            ],
          ),
          if (min != null || summary.membersAtLimit > 0) ...[
            14.0.verticalSpace,
            Wrap(
              spacing: 6.0.w,
              runSpacing: 6.0.h,
              children: [
                if (min != null) StatusChip(colors: summary.meetingsLevel.colors, label: summary.meetingsLevel.meetingsLabel),
                if (summary.membersAtLimit > 0)
                  StatusChip(
                    colors: const StatusColors(
                      dot: AppColorManager.danger,
                      bg: AppColorManager.dangerSoft,
                      fg: AppColorManager.dangerText,
                    ),
                    label: s.membersAtLimit(summary.membersAtLimit),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _Figure extends StatelessWidget {
  const _Figure({required this.value, required this.label, this.color});

  final String value;
  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Directionality(
            textDirection: .ltr,
            child: DrawableText(
              text: value,
              size: 20.0.sp,
              fontWeight: .w700,
              color: color ?? AppColorManager.neutral900,
            ),
          ),
          2.0.verticalSpace,
          DrawableText(text: label, size: 12.0.sp, color: AppColorManager.neutral500, textAlign: .center),
        ],
      ),
    );
  }
}

class _DecisionRow extends StatelessWidget {
  const _DecisionRow({required this.decision});

  final AnnualDecision decision;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return MyCardWidget(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.all(14.0.r),
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          Row(
            children: [
              if (decision.numberLabel.isNotEmpty) ...[
                Directionality(
                  textDirection: .ltr,
                  child: DrawableText(
                    text: '#${decision.numberLabel}',
                    size: 12.0.sp,
                    fontWeight: .w700,
                    color: AppColorManager.primary700,
                  ),
                ),
                8.0.horizontalSpace,
              ],
              Expanded(
                child: DrawableText(
                  text: decision.meetingTitle,
                  size: 12.0.sp,
                  color: AppColorManager.neutral500,
                  maxLines: 1,
                ),
              ),
            ],
          ),
          6.0.verticalSpace,
          DrawableText(text: decision.statement, size: 14.0.sp, color: AppColorManager.neutral900, maxLines: 4),
          if (decision.tasks > 0) ...[
            10.0.verticalSpace,
            ClipRRect(
              borderRadius: BorderRadius.circular(4.0.r),
              child: LinearProgressIndicator(
                value: decision.progress / 100,
                minHeight: 6.0.h,
                color: decision.overdue > 0 ? AppColorManager.warning : AppColorManager.success,
                backgroundColor: AppColorManager.neutral100,
              ),
            ),
            6.0.verticalSpace,
            DrawableText(
              text: [
                s.tasksDoneOf(decision.completed, decision.tasks),
                if (decision.overdue > 0) s.workloadOverdueCount(decision.overdue),
              ].join(' · '),
              size: 12.0.sp,
              color: decision.overdue > 0 ? AppColorManager.warningText : AppColorManager.neutral500,
            ),
          ] else ...[
            6.0.verticalSpace,
            DrawableText(text: s.noTasksForDecision, size: 12.0.sp, color: AppColorManager.neutral500),
          ],
        ],
      ),
    );
  }
}

class _MeetingRow extends StatelessWidget {
  const _MeetingRow({required this.meeting});

  final AnnualMeeting meeting;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final radius = BorderRadius.circular(14.0.r);
    return Material(
      color: AppColorManager.neutral0,
      borderRadius: radius,
      child: InkWell(
        borderRadius: radius,
        onTap: meeting.id.isEmpty
            ? null
            : () => context.pushNamed(RouteName.meeting, queryParameters: {RouteParam.id: meeting.id}),
        child: Ink(
          padding: EdgeInsets.all(14.0.r),
          decoration: BoxDecoration(borderRadius: radius, border: Border.all(color: AppColorManager.neutral100)),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    DrawableText(
                      text: meeting.title,
                      size: 14.0.sp,
                      fontWeight: .w600,
                      color: AppColorManager.neutral900,
                      maxLines: 2,
                    ),
                    4.0.verticalSpace,
                    DrawableText(
                      text: [
                        if (meeting.fromDate != null) meeting.fromDate!.formatDate,
                        if (meeting.invited > 0) s.attendedOf(meeting.attended, meeting.invited),
                      ].join(' · '),
                      size: 12.0.sp,
                      color: AppColorManager.neutral500,
                    ),
                  ],
                ),
              ),
              8.0.horizontalSpace,
              StatusChip.meeting(meeting.status),
            ],
          ),
        ),
      ),
    );
  }
}

class _CirculationRow extends StatelessWidget {
  const _CirculationRow({required this.circulation});

  final AnnualCirculation circulation;

  @override
  Widget build(BuildContext context) {
    final outcome = circulation.outcome;
    return MyCardWidget(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.all(14.0.r),
      child: Row(
        children: [
          if (circulation.numberLabel.isNotEmpty) ...[
            Directionality(
              textDirection: .ltr,
              child: DrawableText(
                text: '#${circulation.numberLabel}',
                size: 12.0.sp,
                fontWeight: .w700,
                color: AppColorManager.primary700,
              ),
            ),
            8.0.horizontalSpace,
          ],
          Expanded(
            child: DrawableText(
              text: circulation.title,
              size: 14.0.sp,
              color: AppColorManager.neutral900,
              maxLines: 2,
            ),
          ),
          if (outcome != null) ...[
            8.0.horizontalSpace,
            StatusChip(colors: outcome.colors, label: outcome.label),
          ],
        ],
      ),
    );
  }
}
