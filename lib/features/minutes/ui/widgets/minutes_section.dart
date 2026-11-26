import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/helper/launcher_helper.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/core/util/snack_bar_message.dart';
import 'package:mms/core/widgets/icon_tile.dart';
import 'package:mms/core/widgets/initials_avatar.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/core/widgets/my_card_widget.dart';
import 'package:mms/core/widgets/reason_sheet.dart';
import 'package:mms/core/widgets/small_widgets.dart';
import 'package:mms/core/widgets/status_chip.dart';
import 'package:mms/features/meetings/data/response/meetings_response.dart';
import 'package:mms/features/minutes/bloc/minutes_cubit/minutes_cubit.dart';
import 'package:mms/features/minutes/data/response/minute_approval_response.dart';
import 'package:mms/generated/l10n.dart';

const _approvedColors = StatusColors(
  dot: AppColorManager.success,
  bg: AppColorManager.successSoft,
  fg: AppColorManager.successText,
);
const _rejectedColors = StatusColors(
  dot: AppColorManager.danger,
  bg: AppColorManager.dangerSoft,
  fg: AppColorManager.dangerText,
);
const _pendingColors = StatusColors(
  dot: AppColorManager.warning,
  bg: AppColorManager.warningSoft,
  fg: AppColorManager.warningText,
);

/// The meeting's minutes: the file, the approval path, my answer, and (for the
/// chair and the secretary) everyone's answers.
class MinutesSection extends StatelessWidget {
  const MinutesSection({super.key, required this.meeting});

  final Meeting meeting;

  static bool showsFor(Meeting meeting) => meeting.minutes.effectiveId.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final minutes = meeting.minutes;
    final role = meeting.callerMembershipType;

    return Padding(
      padding: EdgeInsets.only(top: 24.0.h),
      child: MyCardWidget(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.all(16.0.r),
        child: BlocBuilder<MinutesCubit, MinutesInitial>(
          builder: (context, state) {
            final path = state.result;
            final isFinal = minutes.isPublished || (path?.isFinal ?? false);
            return Column(
              crossAxisAlignment: .stretch,
              children: [
                Row(
                  children: [
                    const IconTile(icon: Icons.history_edu_outlined, size: 44),
                    12.0.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          DrawableText(
                            text: s.minutes,
                            size: 15.0.sp,
                            fontWeight: .w700,
                            color: AppColorManager.neutral900,
                          ),
                          if (minutes.name.isNotEmpty || minutes.date != null) ...[
                            2.0.verticalSpace,
                            DrawableText(
                              text: minutes.name.isNotEmpty ? minutes.name : minutes.date!.formatDate,
                              size: 13.0.sp,
                              color: AppColorManager.neutral500,
                              maxLines: 2,
                            ),
                          ],
                        ],
                      ),
                    ),
                    8.0.horizontalSpace,
                    StatusChip(
                      colors: isFinal ? _approvedColors : _pendingColors,
                      label: isFinal ? s.minutesConfirmed : s.minutesUnderReview,
                    ),
                  ],
                ),
                if (minutes.media?.savedPath.isNotEmpty ?? false) ...[
                  10.0.verticalSpace,
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: MyButton(
                      variant: .text,
                      size: .medium,
                      text: s.openMinutes,
                      startIcon: ImageMultiType(
                        url: Icons.description_outlined,
                        width: 16.0.r,
                        height: 16.0.r,
                        color: AppColorManager.primary500,
                      ),
                      onTap: () => LauncherHelper.openPage(minutes.media!.savedPath),
                    ),
                  ),
                ],
                if (state.statuses == CubitStatuses.loading && path == null) ...[
                  12.0.verticalSpace,
                  SkeletonBox(height: 44.0.h),
                ] else if (path != null) ...[
                  const _Divider(),
                  _Progress(path: path),
                  if (!isFinal && role != MembershipType.secretary) ...[
                    const _Divider(),
                    _MyAnswer(path: path, answer: state.myAnswer, isChair: role?.isChair ?? false, sending: state.sending),
                  ],
                  if (state.isLead && state.approvals.isNotEmpty) ...[
                    const _Divider(),
                    _Approvals(items: state.approvals),
                  ],
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Divider(height: 1, color: AppColorManager.neutral100),
    );
  }
}

/// "3 of 7 approved", the bar, the deadline and the chair-last rule.
class _Progress extends StatelessWidget {
  const _Progress({required this.path});

  final MinuteApprovalPath path;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final total = path.approvers;
    final deadline = path.approvalDeadline;
    return Column(
      crossAxisAlignment: .stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: DrawableText(
                text: s.minutesApprovedOf(path.approved, total),
                size: 14.0.sp,
                fontWeight: .w700,
                color: AppColorManager.neutral900,
              ),
            ),
            if (path.rejected > 0) ...[
              StatusChip(colors: _rejectedColors, label: s.minutesRejectedCount(path.rejected)),
              6.0.horizontalSpace,
            ],
            if (path.pending > 0) StatusChip(colors: _pendingColors, label: s.pendingCount(path.pending)),
          ],
        ),
        8.0.verticalSpace,
        ClipRRect(
          borderRadius: BorderRadius.circular(4.0.r),
          child: LinearProgressIndicator(
            value: total == 0 ? 0 : path.approved / total,
            minHeight: 6.0.h,
            color: AppColorManager.success,
            backgroundColor: AppColorManager.neutral100,
          ),
        ),
        if (deadline != null || path.closed) ...[
          8.0.verticalSpace,
          DrawableText(
            text: path.closed ? s.minutesAnswersClosed : s.minutesAnswerBy(deadline!.formatDateTime),
            size: 12.0.sp,
            color: path.closed ? AppColorManager.dangerText : AppColorManager.neutral500,
          ),
        ],
        if (path.chairApprovesLast) ...[
          4.0.verticalSpace,
          DrawableText(text: s.minutesChairLast, size: 12.0.sp, color: AppColorManager.neutral500),
        ],
      ],
    );
  }
}

/// My answer, and Approve / Reject while answers are taken.
class _MyAnswer extends StatelessWidget {
  const _MyAnswer({required this.path, required this.answer, required this.isChair, required this.sending});

  final MinuteApprovalPath path;
  final MinuteApproval? answer;
  final bool isChair;
  final bool sending;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final cubit = context.read<MinutesCubit>();
    // With "chair approves last", the chair waits for everyone else (rejecting is always allowed).
    final chairWaits = isChair && path.chairApprovesLast && !path.chairsTurn;
    final mine = answer?.isApproved;

    return Column(
      crossAxisAlignment: .stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: DrawableText(
                text: s.yourAnswer,
                size: 13.0.sp,
                fontWeight: .w600,
                color: AppColorManager.neutral500,
              ),
            ),
            StatusChip(
              colors: switch (mine) {
                true => _approvedColors,
                false => _rejectedColors,
                null => _pendingColors,
              },
              label: switch (mine) {
                true => s.youApproved,
                false => s.youRejected,
                null => s.notAnsweredYet,
              },
            ),
          ],
        ),
        if (mine == false && (answer?.reason.isNotEmpty ?? false)) ...[
          6.0.verticalSpace,
          DrawableText(
            text: '${s.rejectionReason}: ${answer!.reason}',
            size: 13.0.sp,
            color: AppColorManager.dangerText,
          ),
        ],
        if (chairWaits) ...[
          8.0.verticalSpace,
          DrawableText(text: s.minutesChairWaits, size: 13.0.sp, color: AppColorManager.warningText),
        ],
        if (path.open) ...[
          10.0.verticalSpace,
          Row(
            children: [
              Expanded(
                child: MyButton(
                  variant: .dangerSoft,
                  size: .medium,
                  enable: !sending && mine != false,
                  text: s.reject,
                  onTap: () async {
                    final reason = await ReasonSheet.show(
                      context,
                      title: s.rejectMinutesTitle,
                      hint: s.rejectMinutesHint,
                      confirmText: s.reject,
                      destructive: true,
                      maxLength: 500,
                    );
                    if (reason == null || reason.isEmpty) return;
                    final ok = await cubit.answer(isApproved: false, reason: reason);
                    if (ok && context.mounted) {
                      NoteMessage.showSuccessSnackBar(message: s.minutesRejectedDone, context: context);
                    }
                  },
                ),
              ),
              8.0.horizontalSpace,
              Expanded(
                child: MyButton(
                  variant: .tonal,
                  size: .medium,
                  loading: sending,
                  enable: !chairWaits && mine != true,
                  text: s.approve,
                  onTap: () async {
                    final ok = await cubit.answer(isApproved: true);
                    if (ok && context.mounted) {
                      NoteMessage.showSuccessSnackBar(message: s.minutesApprovedDone, context: context);
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

/// Everyone's answers (chair and secretary).
class _Approvals extends StatelessWidget {
  const _Approvals({required this.items});

  final List<MinuteApproval> items;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Column(
      crossAxisAlignment: .stretch,
      children: [
        DrawableText(
          text: s.minutesApprovals,
          size: 13.0.sp,
          fontWeight: .w600,
          color: AppColorManager.neutral500,
        ),
        8.0.verticalSpace,
        for (final item in items)
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: 44.0.h),
            child: Padding(
              padding: EdgeInsets.only(bottom: 8.0.h),
              child: Row(
                crossAxisAlignment: .start,
                children: [
                  InitialsAvatar(name: item.name, size: 32),
                  10.0.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        DrawableText(
                          text: item.name,
                          size: 14.0.sp,
                          fontWeight: .w600,
                          color: AppColorManager.neutral900,
                        ),
                        if (item.reason.isNotEmpty)
                          DrawableText(
                            text: item.reason,
                            size: 12.0.sp,
                            color: AppColorManager.neutral500,
                            maxLines: 4,
                          ),
                      ],
                    ),
                  ),
                  8.0.horizontalSpace,
                  StatusChip(
                    colors: switch (item.isApproved) {
                      true => _approvedColors,
                      false => _rejectedColors,
                      null => _pendingColors,
                    },
                    label: switch (item.isApproved) {
                      true => s.approvedState,
                      false => s.rejectedState,
                      null => s.notAnsweredYet,
                    },
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
