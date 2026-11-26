import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/core/widgets/app_bar/app_bar_widget.dart';
import 'package:mms/core/widgets/empty_state_widget.dart';
import 'package:mms/core/widgets/initials_avatar.dart';
import 'package:mms/core/widgets/membership_badge.dart';
import 'package:mms/core/widgets/my_card_widget.dart';
import 'package:mms/core/widgets/refresh_widget/refresh_widget.dart';
import 'package:mms/core/widgets/small_widgets.dart';
import 'package:mms/core/widgets/status_chip.dart';
import 'package:mms/features/compliance/bloc/compliance_cubit/compliance_cubit.dart';
import 'package:mms/features/compliance/data/response/compliance_response.dart';
import 'package:mms/core/widgets/year_switcher.dart';
import 'package:mms/generated/l10n.dart';

/// A committee's attendance for a year: meetings against the yearly minimum, members
/// at risk, and everyone's attendance. A plain member sees only their own row.
class CompliancePage extends StatelessWidget {
  const CompliancePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ComplianceCubit>();
    final s = S.of(context);

    return Scaffold(
      appBar: AppBarWidget(titleText: s.attendanceCompliance),
      body: BlocBuilder<ComplianceCubit, ComplianceInitial>(
        builder: (context, state) {
          final data = state.result;
          final me = AppProvider.getParty.id;
          final onlyMine = data.members.length <= 1 && data.members.every((e) => e.partyId == me);
          final Widget content;

          if (state.loading && data.isEmpty) {
            content = Column(
              children: [
                const SkeletonBox(height: 120, radius: 14),
                16.0.verticalSpace,
                for (var i = 0; i < 4; i++) ...[const SkeletonBox(height: 76, radius: 14), 12.0.verticalSpace],
              ],
            );
          } else if (state.statuses == CubitStatuses.error && data.isEmpty) {
            content = Padding(
              padding: EdgeInsets.only(top: 60.0.h),
              child: EmptyStateWidget.large(
                icon: Icons.event_busy_outlined,
                title: s.attendanceUnavailable,
                description: state.error,
              ),
            );
          } else {
            final atRisk = onlyMine ? const <ComplianceMember>[] : data.atRisk;
            content = Column(
              crossAxisAlignment: .stretch,
              children: [
                _MeetingsCard(data: data),
                if (atRisk.isNotEmpty) ...[
                  20.0.verticalSpace,
                  SectionHeader(title: s.membersAtRisk, trailing: '${atRisk.length}'),
                  10.0.verticalSpace,
                  for (final m in atRisk) ...[_MemberCard(member: m, rule: data.rule), 12.0.verticalSpace],
                ],
                if (data.members.isNotEmpty) ...[
                  20.0.verticalSpace,
                  SectionHeader(
                    title: onlyMine ? s.myAttendance : s.allMembers,
                    trailing: onlyMine ? null : s.membersCount(data.members.length),
                  ),
                  10.0.verticalSpace,
                  for (final m in data.members) ...[_MemberCard(member: m, rule: data.rule), 12.0.verticalSpace],
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
                YearSwitcher(
                  year: state.year,
                  onChange: (y) => cubit.getData(year: y),
                ),
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

/// Meetings held / scheduled against the yearly minimum.
class _MeetingsCard extends StatelessWidget {
  const _MeetingsCard({required this.data});

  final ComplianceStatus data;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final min = data.rule.minMeetingsPerYear;
    return MyCardWidget(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.all(16.0.r),
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: DrawableText(
                  text: s.meetingsThisYear,
                  size: 15.0.sp,
                  fontWeight: .w700,
                  color: AppColorManager.neutral900,
                ),
              ),
              if (min != null) StatusChip(colors: data.meetingsLevel.colors, label: data.meetingsLevel.meetingsLabel),
            ],
          ),
          14.0.verticalSpace,
          Row(
            children: [
              _Figure(value: '${data.meetingsHeld}', label: s.meetingsHeld),
              _Figure(value: '${data.meetingsScheduled}', label: s.meetingsScheduledLabel),
              _Figure(value: min == null ? '–' : '$min', label: s.meetingsMinimum),
            ],
          ),
          if (min != null && data.meetingsMissing > 0) ...[
            12.0.verticalSpace,
            DrawableText(
              text: s.meetingsMissing(data.meetingsMissing),
              size: 13.0.sp,
              color: data.meetingsOnTrack ? AppColorManager.neutral500 : AppColorManager.warningText,
            ),
          ],
          if (!data.rule.hasRule) ...[
            12.0.verticalSpace,
            DrawableText(text: s.noComplianceRule, size: 13.0.sp, color: AppColorManager.neutral500),
          ],
        ],
      ),
    );
  }
}

class _Figure extends StatelessWidget {
  const _Figure({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          DrawableText(text: value, size: 22.0.sp, fontWeight: .w700, color: AppColorManager.neutral900),
          2.0.verticalSpace,
          DrawableText(text: label, size: 12.0.sp, color: AppColorManager.neutral500, textAlign: .center),
        ],
      ),
    );
  }
}

class _MemberCard extends StatelessWidget {
  const _MemberCard({required this.member, required this.rule});

  final ComplianceMember member;
  final ComplianceRule rule;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final rate = member.attendanceRate;
    final details = [
      s.attendedOf(member.attended, member.invited),
      s.absencesCount(member.absences),
      if (member.excused > 0) s.excusedCount(member.excused),
      if (member.absencesInRow > 1) s.absencesInRow(member.absencesInRow),
    ].join(' · ');

    return MyCardWidget(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.all(14.0.r),
      child: Row(
        children: [
          InitialsAvatar(name: member.name, size: 40),
          12.0.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: DrawableText(
                        text: member.name,
                        size: 14.0.sp,
                        fontWeight: .w700,
                        color: AppColorManager.neutral900,
                        maxLines: 1,
                      ),
                    ),
                    if (!member.membershipType.isMember) ...[
                      6.0.horizontalSpace,
                      MembershipBadge(type: member.membershipType),
                    ],
                  ],
                ),
                4.0.verticalSpace,
                DrawableText(text: details, size: 12.0.sp, color: AppColorManager.neutral500, maxLines: 2),
              ],
            ),
          ),
          8.0.horizontalSpace,
          Column(
            crossAxisAlignment: .end,
            children: [
              Directionality(
                textDirection: .ltr,
                child: DrawableText(
                  text: rate == null ? '–' : '$rate%',
                  size: 16.0.sp,
                  fontWeight: .w700,
                  color: AppColorManager.neutral900,
                ),
              ),
              if (rule.hasRule && member.level != ComplianceLevel.ok) ...[
                4.0.verticalSpace,
                StatusChip(colors: member.level.colors, label: member.level.label),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
