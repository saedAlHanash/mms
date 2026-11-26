import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/core/widgets/icon_tile.dart';
import 'package:mms/core/widgets/my_card_widget.dart';
import 'package:mms/core/widgets/status_chip.dart';
import 'package:mms/features/meetings/data/response/meetings_response.dart';
import 'package:mms/features/quorum/bloc/quorum_cubit/quorum_cubit.dart';
import 'package:mms/features/quorum/data/response/quorum_response.dart';
import 'package:mms/generated/l10n.dart';

/// Quorum on the meeting page outside the live panel:
/// - Scheduled: the live figure from check-ins so far.
/// - Completed / archived: the figure saved when the meeting started.
///
/// Hidden when the committee has no rule (or nothing was recorded).
class QuorumCard extends StatelessWidget {
  const QuorumCard({super.key, required this.meeting});

  final Meeting meeting;

  /// Running meetings show the quorum in the live panel instead.
  static bool showsFor(Meeting meeting) => switch (meeting.status) {
        MeetingStatus.scheduled || MeetingStatus.completed || MeetingStatus.archived => true,
        _ => false,
      };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuorumCubit, QuorumInitial>(
      builder: (context, state) {
        final q = state.result;
        if (!q.hasRule) return const SizedBox.shrink();

        final recorded = meeting.status != MeetingStatus.scheduled;
        if (recorded && !q.hasRecord) return const SizedBox.shrink();

        final present = recorded ? q.recordedPresent! : q.present;
        final required = recorded ? q.recordedRequired! : q.required;
        final met = recorded ? (q.recordedMet ?? present >= required) : q.met;

        return Padding(
          padding: EdgeInsets.only(top: 16.0.h),
          child: MyCardWidget(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.all(16.0.r),
            child: Column(
              crossAxisAlignment: .stretch,
              children: [
                Row(
                  children: [
                    IconTile(icon: Icons.groups_2_outlined, size: 44, tone: met ? .primary : .neutral),
                    12.0.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          DrawableText(
                            text: S.of(context).quorumTitle,
                            size: 15.0.sp,
                            fontWeight: .w700,
                            color: AppColorManager.neutral900,
                          ),
                          2.0.verticalSpace,
                          DrawableText(
                            text: _ruleText(context, q),
                            size: 12.0.sp,
                            color: AppColorManager.neutral500,
                          ),
                        ],
                      ),
                    ),
                    StatusChip(
                      colors: met ? PollOutcome.passed.colors : PollOutcome.tied.colors,
                      label: met ? S.of(context).quorumStatusMet : S.of(context).quorumStatusNotMet,
                    ),
                  ],
                ),
                14.0.verticalSpace,
                _Meter(present: present, required: required, met: met),
                10.0.verticalSpace,
                DrawableText(
                  text: S.of(context).quorumPresentOfRequired(present, required),
                  size: 13.0.sp,
                  fontWeight: .w600,
                  color: AppColorManager.neutral700,
                ),
                if (!recorded) ...[
                  4.0.verticalSpace,
                  DrawableText(
                    text: S.of(context).quorumSplit(q.presentInHall, q.presentRemote),
                    size: 12.0.sp,
                    color: AppColorManager.neutral500,
                  ),
                  if (q.proxiesCount && q.proxies > 0) ...[
                    2.0.verticalSpace,
                    DrawableText(
                      text: S.of(context).quorumProxies(q.proxies),
                      size: 12.0.sp,
                      color: AppColorManager.neutral500,
                    ),
                  ],
                  if (q.chairRequired && !q.chairPresent) ...[
                    10.0.verticalSpace,
                    _Note(
                      text: (meeting.callerMembershipType?.isChair ?? false)
                          ? S.of(context).quorumChairRequiredYou
                          : S.of(context).quorumChairRequired,
                    ),
                  ],
                ] else ...[
                  4.0.verticalSpace,
                  DrawableText(
                    text: S.of(context).quorumRecordedAt(q.recordedAt!.formatTime),
                    size: 12.0.sp,
                    color: AppColorManager.neutral500,
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  String _ruleText(BuildContext context, MeetingQuorum q) {
    final value = q.value ?? q.required;
    return switch (q.type) {
      QuorumType.percent => S.of(context).quorumRulePercent(value, q.base),
      _ => S.of(context).quorumRuleCount(value),
    };
  }
}

/// Present against required, with a tick where the requirement sits.
class _Meter extends StatelessWidget {
  const _Meter({required this.present, required this.required, required this.met});

  final int present;
  final int required;
  final bool met;

  @override
  Widget build(BuildContext context) {
    // Scale so the requirement sits at most at 80% and a surplus still shows.
    final scale = [present, required, 1].reduce((a, b) => a > b ? a : b) * 1.25;
    final ratio = (present / scale).clamp(0.0, 1.0);
    final mark = (required / scale).clamp(0.0, 1.0);

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        return SizedBox(
          height: 14.0.h,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(
                top: 3.0.h,
                bottom: 3.0.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    value: ratio,
                    backgroundColor: AppColorManager.neutral100,
                    color: met ? AppColorManager.success : AppColorManager.warning,
                  ),
                ),
              ),
              if (required > 0)
                PositionedDirectional(
                  start: width * mark - 1,
                  top: 0,
                  bottom: 0,
                  child: Container(width: 2, color: AppColorManager.neutral700),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _Note extends StatelessWidget {
  const _Note({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 10.0.h),
      decoration: BoxDecoration(
        color: AppColorManager.warningSoft,
        borderRadius: BorderRadius.circular(12.0.r),
      ),
      child: DrawableText(
        text: text,
        size: 13.0.sp,
        fontWeight: .w600,
        color: AppColorManager.warningText,
        drawablePadding: 8.0.w,
        drawableStart: ImageMultiType(
          url: Icons.info_outline_rounded,
          width: 18.0.r,
          height: 18.0.r,
          color: AppColorManager.warningText,
        ),
      ),
    );
  }
}
