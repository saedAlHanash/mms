import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/widgets/app_bar/app_bar_widget.dart';
import 'package:mms/core/widgets/icon_tile.dart';
import 'package:mms/core/widgets/refresh_widget/refresh_widget.dart';
import 'package:mms/core/widgets/small_widgets.dart';
import 'package:mms/features/committees/bloc/committee_cubit/committee_cubit.dart';
import 'package:mms/features/documents/ui/widget/documents_list_widget.dart';
import 'package:mms/features/goals/ui/widget/goals_list_widget.dart';
import 'package:mms/features/members/ui/widget/members_list_widget.dart';
import 'package:mms/generated/l10n.dart';
import 'package:mms/router/app_router.dart';

class CommitteePage extends StatelessWidget {
  const CommitteePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: BlocBuilder<CommitteeCubit, CommitteeInitial>(
          builder: (context, state) {
            return DrawableText(
              text: state.result.name,
              size: 18.0.sp,
              fontWeight: .w700,
              color: AppColorManager.neutral900,
              maxLines: 2,
            );
          },
        ),
      ),
      endDrawer: Drawer(
        width: 320.0.w,
        backgroundColor: AppColorManager.neutral0,
        surfaceTintColor: AppColorManager.neutral0,
        shape: const RoundedRectangleBorder(),
        child: BlocBuilder<CommitteeCubit, CommitteeInitial>(
          builder: (context, state) => MembersListWidget(members: state.result.members),
        ),
      ),
      body: BlocBuilder<CommitteeCubit, CommitteeInitial>(
        builder: (context, state) {
          final item = state.result;
          final showSkeleton = state.loading && item.id.isEmpty;

          return RefreshWidget(
            isLoading: state.loading,
            onRefresh: () => context.read<CommitteeCubit>().getData(newData: true),
            child: showSkeleton
                ? const _CommitteeSkeleton()
                : ListView(
                    padding: EdgeInsets.fromLTRB(20.0.w, 16.0.h, 20.0.w, 32.0.h),
                    children: [
                      // Membership + formation date.
                      Wrap(
                        spacing: 12.0.w,
                        runSpacing: 8.0.h,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                            decoration: BoxDecoration(
                              color: AppColorManager.primary100,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: DrawableText(
                              text: '${S.of(context).yourMembership}: ${item.member.membershipType.name}',
                              size: 13.0.sp,
                              fontWeight: .w600,
                              color: AppColorManager.primary700,
                            ),
                          ),
                          if (item.formationDate != null)
                            Row(
                              mainAxisSize: .min,
                              children: [
                                ImageMultiType(
                                  url: Icons.calendar_today_outlined,
                                  width: 15.0.r,
                                  height: 15.0.r,
                                  color: AppColorManager.neutral500,
                                ),
                                6.0.horizontalSpace,
                                DrawableText(
                                  text: S.of(context).formationDate,
                                  size: 13.0.sp,
                                  color: AppColorManager.neutral700,
                                ),
                                6.0.horizontalSpace,
                                Directionality(
                                  textDirection: .ltr,
                                  child: DrawableText(
                                    text: item.formationDate!.formatDate,
                                    size: 13.0.sp,
                                    fontWeight: .w600,
                                    color: AppColorManager.neutral900,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                      12.0.verticalSpace,
                      // Action cards.
                      Row(
                        children: [
                          Expanded(
                            child: Builder(
                              builder: (context) => _ActionCard(
                                icon: Icons.groups_outlined,
                                title: S.of(context).members,
                                subtitle: S.of(context).membersCount(item.members.length),
                                onTap: () => Scaffold.of(context).openEndDrawer(),
                              ),
                            ),
                          ),
                          12.0.horizontalSpace,
                          Expanded(
                            child: _ActionCard(
                              icon: Icons.calendar_month_outlined,
                              title: S.of(context).meetings,
                              subtitle: S.of(context).committeeCalendar,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  RouteName.calenderMeetings,
                                  arguments: FilterRequest(
                                    filters: {
                                      "committeeId": Filter(
                                        name: 'committeeId',
                                        val: context.read<CommitteeCubit>().state.uuid,
                                      ),
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      24.0.verticalSpace,
                      // Description + statement.
                      Container(
                        padding: EdgeInsets.all(16.0.r),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColorManager.neutral100),
                          borderRadius: BorderRadius.circular(12.0.r),
                        ),
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            _SmallTitle(text: S.of(context).committeeDescription),
                            6.0.verticalSpace,
                            _ExpandableText(
                              text: item.description,
                              emptyText: S.of(context).noCommitteeDescription,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 4.0.h, bottom: 12.0.h),
                              child: const Divider(height: 1, color: AppColorManager.neutral50),
                            ),
                            _SmallTitle(text: S.of(context).committeeStatement),
                            6.0.verticalSpace,
                            _ExpandableText(
                              text: item.statement,
                              emptyText: S.of(context).noCommitteeStatement,
                            ),
                          ],
                        ),
                      ),
                      24.0.verticalSpace,
                      SectionHeader(
                        title: S.of(context).documents,
                        trailing: item.documents.isEmpty ? null : S.of(context).documentsCount(item.documents.length),
                      ),
                      10.0.verticalSpace,
                      DocumentsListWidget(documents: item.documents),
                      24.0.verticalSpace,
                      SectionHeader(
                        title: S.of(context).goals,
                        trailing: item.goals.isEmpty ? null : S.of(context).goalsCount(item.goals.length),
                      ),
                      10.0.verticalSpace,
                      GoalListWidget(goals: item.goals),
                    ],
                  ),
          );
        },
      ),
    );
  }
}

class _SmallTitle extends StatelessWidget {
  const _SmallTitle({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return DrawableText(
      text: text,
      size: 13.0.sp,
      fontWeight: .w700,
      color: AppColorManager.neutral500,
    );
  }
}

/// Bordered card: 40 icon tile + title 15/700 + subtitle 13.
class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColorManager.neutral0,
      borderRadius: BorderRadius.circular(12.0.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0.r),
        onTap: onTap,
        child: Ink(
          padding: EdgeInsets.all(12.0.r),
          decoration: BoxDecoration(
            border: Border.all(color: AppColorManager.neutral100),
            borderRadius: BorderRadius.circular(12.0.r),
          ),
          child: Row(
            children: [
              IconTile(icon: icon, size: 40, iconSize: 20),
              10.0.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  mainAxisSize: .min,
                  children: [
                    DrawableText(
                      text: title,
                      size: 15.0.sp,
                      fontWeight: .w700,
                      color: AppColorManager.neutral900,
                      maxLines: 1,
                    ),
                    DrawableText(
                      text: subtitle,
                      size: 13.0.sp,
                      color: AppColorManager.neutral500,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 15/26 text clamped to 3 lines with a "Show more / Show less" toggle
/// (only when the text is longer than 3 lines).
class _ExpandableText extends StatefulWidget {
  const _ExpandableText({required this.text, required this.emptyText});

  final String text;
  final String emptyText;

  @override
  State<_ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<_ExpandableText> {
  static const _maxLines = 3;
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    if (widget.text.trim().isEmpty) {
      return DrawableText(
        text: widget.emptyText,
        size: 15.0.sp,
        color: AppColorManager.neutral500,
        matchParent: true,
      );
    }

    final style = TextStyle(
      fontSize: 15.0.sp,
      height: 26 / 15,
      color: AppColorManager.neutral700,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final painter = TextPainter(
          text: TextSpan(text: widget.text, style: style),
          maxLines: _maxLines,
          textDirection: Directionality.of(context),
          textScaler: MediaQuery.textScalerOf(context),
        )..layout(maxWidth: constraints.maxWidth);
        final overflows = painter.didExceedMaxLines;

        return Column(
          crossAxisAlignment: .start,
          children: [
            DrawableText(
              text: widget.text,
              style: Theme.of(context).textTheme.bodyMedium?.merge(style),
              maxLines: _expanded ? null : _maxLines,
              matchParent: true,
            ),
            if (overflows || _expanded)
              TextButton(
                onPressed: () => setState(() => _expanded = !_expanded),
                style: TextButton.styleFrom(
                  minimumSize: Size(44.0.w, 44.0.h),
                  padding: EdgeInsets.zero,
                ),
                child: DrawableText(
                  text: _expanded ? S.of(context).showLess : S.of(context).showMore,
                  size: 14.0.sp,
                  fontWeight: .w700,
                  color: AppColorManager.primary600,
                ),
              ),
          ],
        );
      },
    );
  }
}

class _CommitteeSkeleton extends StatelessWidget {
  const _CommitteeSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(20.0.w, 16.0.h, 20.0.w, 32.0.h),
      children: [
        Row(
          children: [
            SkeletonBox(width: 96.0.w, height: 24, radius: 999),
            8.0.horizontalSpace,
            SkeletonBox(width: 150.0.w, height: 24, radius: 999),
          ],
        ),
        24.0.verticalSpace,
        Row(
          children: [
            const Expanded(child: SkeletonBox(height: 66, radius: 12)),
            12.0.horizontalSpace,
            const Expanded(child: SkeletonBox(height: 66, radius: 12)),
          ],
        ),
        24.0.verticalSpace,
        const SkeletonBox(height: 180, radius: 12),
        24.0.verticalSpace,
        SkeletonBox(width: 120.0.w, height: 20, radius: 6),
        10.0.verticalSpace,
        const SkeletonBox(height: 128, radius: 12),
        24.0.verticalSpace,
        SkeletonBox(width: 120.0.w, height: 20, radius: 6),
        10.0.verticalSpace,
        const SkeletonBox(height: 128, radius: 12),
      ],
    );
  }
}
