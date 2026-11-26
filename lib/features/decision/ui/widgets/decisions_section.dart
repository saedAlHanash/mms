import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/core/util/snack_bar_message.dart';
import 'package:mms/core/widgets/initials_avatar.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/core/widgets/my_card_widget.dart';
import 'package:mms/core/widgets/reason_sheet.dart';
import 'package:mms/core/widgets/small_widgets.dart';
import 'package:mms/core/widgets/status_chip.dart';
import 'package:mms/features/decision/bloc/decision_reservation_cubit/decision_reservation_cubit.dart';
import 'package:mms/features/meetings/bloc/meeting_cubit/meeting_cubit.dart';
import 'package:mms/features/meetings/data/response/meetings_response.dart';
import 'package:mms/generated/l10n.dart';

/// The meeting's decisions. Members reserve on a published decision (with a reason)
/// and may withdraw it; the chair and the secretary also see unpublished decisions
/// and everyone's reservations (like the web, they don't reserve themselves).
class DecisionsSection extends StatelessWidget {
  const DecisionsSection({super.key, required this.meeting});

  final Meeting meeting;

  static bool showsFor(Meeting meeting) => meeting.decisions.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final isLead = meeting.callerMembershipType?.isLead ?? false;
    final canReserve = !isLead && meeting.status != MeetingStatus.archived && meeting.status != MeetingStatus.canceled;

    return Padding(
      padding: EdgeInsets.only(top: 24.0.h),
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          SectionHeader(title: s.decisions, trailing: s.decisionsCount(meeting.decisions.length)),
          10.0.verticalSpace,
          MyCardWidget(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.all(16.0.r),
            child: BlocBuilder<DecisionReservationCubit, DecisionReservationInitial>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: .stretch,
                  children: [
                    for (final d in meeting.decisions) ...[
                      if (d != meeting.decisions.first)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Divider(height: 1, color: AppColorManager.neutral100),
                        ),
                      _DecisionItem(
                        decision: d,
                        isLead: isLead,
                        canReserve: canReserve && d.isPublished,
                        busy: state.busyId == d.id,
                      ),
                    ],
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _DecisionItem extends StatelessWidget {
  const _DecisionItem({required this.decision, required this.isLead, required this.canReserve, required this.busy});

  final Decision decision;
  final bool isLead;
  final bool canReserve;
  final bool busy;

  Future<void> _reserve(BuildContext context) async {
    final s = S.of(context);
    final cubit = context.read<DecisionReservationCubit>();
    final meetingCubit = context.read<MeetingCubit>();
    final reason = await ReasonSheet.show(
      context,
      title: s.reserveTitle,
      description: decision.statement,
      hint: s.reserveHint,
      confirmText: s.reserveOnDecision,
      maxLength: 500,
    );
    if (reason == null || reason.isEmpty) return;
    if (await cubit.reserve(decision.id, reason: reason) && context.mounted) {
      NoteMessage.showSuccessSnackBar(message: s.reservationSent, context: context);
      meetingCubit.getData(newData: true);
    }
  }

  void _withdraw(BuildContext context) {
    final s = S.of(context);
    final cubit = context.read<DecisionReservationCubit>();
    final meetingCubit = context.read<MeetingCubit>();
    NoteMessage.showCheckDialog(
      context,
      text: s.withdrawReservationTitle,
      description: decision.statement,
      textButton: s.withdrawReservation,
      image: Icons.undo_rounded,
      destructive: true,
      onConfirm: () async {
        if (await cubit.withdraw(decision.id) && context.mounted) {
          NoteMessage.showSuccessSnackBar(message: s.reservationWithdrawn, context: context);
          meetingCubit.getData(newData: true);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final mine = decision.myReservation;
    final others = decision.reservations;

    return Column(
      crossAxisAlignment: .stretch,
      children: [
        Row(
          children: [
            if (decision.numberLabel.isNotEmpty)
              Directionality(
                textDirection: .ltr,
                child: DrawableText(
                  text: '#${decision.numberLabel}',
                  size: 12.0.sp,
                  fontWeight: .w700,
                  color: AppColorManager.primary700,
                ),
              ),
            const Spacer(),
            if (isLead && !decision.isPublished)
              StatusChip(
                colors: const StatusColors(
                  dot: AppColorManager.neutral500,
                  bg: AppColorManager.neutral50,
                  fg: AppColorManager.neutral700,
                ),
                label: s.unpublished,
              ),
            if (others.isNotEmpty) ...[
              6.0.horizontalSpace,
              StatusChip(
                colors: const StatusColors(
                  dot: AppColorManager.warning,
                  bg: AppColorManager.warningSoft,
                  fg: AppColorManager.warningText,
                ),
                label: s.reservationsCount(others.length),
              ),
            ],
          ],
        ),
        6.0.verticalSpace,
        DrawableText(
          text: decision.statement,
          size: 14.0.sp,
          color: AppColorManager.neutral900,
          matchParent: true,
        ),
        // The chair and the secretary see who reserved and why.
        if (isLead && others.isNotEmpty) ...[
          10.0.verticalSpace,
          for (final r in others)
            Padding(
              padding: EdgeInsets.only(bottom: 8.0.h),
              child: Row(
                crossAxisAlignment: .start,
                children: [
                  InitialsAvatar(name: r.name, size: 28),
                  8.0.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        DrawableText(
                          text: r.name,
                          size: 13.0.sp,
                          fontWeight: .w600,
                          color: AppColorManager.neutral900,
                        ),
                        if (r.reason.isNotEmpty)
                          DrawableText(text: r.reason, size: 12.0.sp, color: AppColorManager.neutral500, maxLines: 4),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
        if (!isLead && mine != null) ...[
          10.0.verticalSpace,
          Container(
            padding: EdgeInsets.all(10.0.r),
            decoration: BoxDecoration(
              color: AppColorManager.warningSoft,
              borderRadius: BorderRadius.circular(8.0.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      DrawableText(
                        text: s.yourReservation,
                        size: 12.0.sp,
                        fontWeight: .w700,
                        color: AppColorManager.warningText,
                      ),
                      if (mine.reason.isNotEmpty)
                        DrawableText(text: mine.reason, size: 13.0.sp, color: AppColorManager.neutral700, maxLines: 4),
                    ],
                  ),
                ),
                if (canReserve)
                  MyButton(
                    variant: .text,
                    size: .medium,
                    loading: busy,
                    text: s.withdrawReservation,
                    onTap: () => _withdraw(context),
                  ),
              ],
            ),
          ),
        ] else if (canReserve) ...[
          10.0.verticalSpace,
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: MyButton(
              variant: .outline,
              size: .medium,
              loading: busy,
              text: s.reserveOnDecision,
              onTap: () => _reserve(context),
            ),
          ),
        ],
      ],
    );
  }
}
