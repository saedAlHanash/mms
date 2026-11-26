import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/core/util/snack_bar_message.dart';
import 'package:mms/core/widgets/icon_tile.dart';
import 'package:mms/core/widgets/initials_avatar.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/core/widgets/my_card_widget.dart';
import 'package:mms/core/widgets/status_chip.dart';
import 'package:mms/features/absence/bloc/absence_review_cubit/absence_review_cubit.dart';
import 'package:mms/features/meetings/bloc/meeting_cubit/meeting_cubit.dart';
import 'package:mms/features/meetings/data/response/meetings_response.dart';
import 'package:mms/generated/l10n.dart';

/// The chair's answer to members' absence requests, while the meeting is scheduled.
/// Only the chair may answer (the secretary gets 403).
class AbsenceRequestsSection extends StatelessWidget {
  const AbsenceRequestsSection({super.key, required this.meeting});

  final Meeting meeting;

  static bool showsFor(Meeting meeting) =>
      (meeting.callerMembershipType?.isChair ?? false) &&
      meeting.status == MeetingStatus.scheduled &&
      meeting.absenceRequests.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AbsenceReviewCubit, AbsenceReviewInitial>(
      builder: (context, state) {
        AbsenceStatus statusOf(AbsenceRequest e) => state.answered[e.id] ?? e.absenceStatus;

        // Pending first, then newest.
        final list = [...meeting.absenceRequests]
          ..sort((a, b) {
            final pa = statusOf(a) == AbsenceStatus.pending ? 0 : 1;
            final pb = statusOf(b) == AbsenceStatus.pending ? 0 : 1;
            if (pa != pb) return pa.compareTo(pb);
            return (b.date ?? DateTime(0)).compareTo(a.date ?? DateTime(0));
          });
        final pending = list.where((e) => statusOf(e) == AbsenceStatus.pending).length;

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
                    const IconTile(icon: Icons.event_busy_outlined, size: 44),
                    12.0.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          DrawableText(
                            text: S.of(context).absenceRequests,
                            size: 15.0.sp,
                            fontWeight: .w700,
                            color: AppColorManager.neutral900,
                          ),
                          2.0.verticalSpace,
                          DrawableText(
                            text: S.of(context).absenceRequestsHint,
                            size: 13.0.sp,
                            color: AppColorManager.neutral500,
                          ),
                        ],
                      ),
                    ),
                    if (pending > 0)
                      StatusChip(colors: AbsenceStatus.pending.colors, label: S.of(context).pendingCount(pending)),
                  ],
                ),
                for (final item in list) ...[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Divider(height: 1, color: AppColorManager.neutral100),
                  ),
                  _AbsenceItem(item: item, status: statusOf(item), busy: state.busyId == item.id),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AbsenceItem extends StatelessWidget {
  const _AbsenceItem({required this.item, required this.status, required this.busy});

  final AbsenceRequest item;
  final AbsenceStatus status;
  final bool busy;

  void _answer(BuildContext context, {required bool accept}) {
    final s = S.of(context);
    final cubit = context.read<AbsenceReviewCubit>();
    final meetingCubit = context.read<MeetingCubit>();
    NoteMessage.showCheckDialog(
      context,
      text: accept ? s.acceptAbsenceTitle : s.rejectAbsenceTitle,
      description: item.name,
      textButton: accept ? s.acceptAbsence : s.reject,
      image: accept ? Icons.event_available_outlined : Icons.event_busy_outlined,
      destructive: !accept,
      onConfirm: () async {
        final done = accept ? await cubit.accept(item.id) : await cubit.reject(item.id);
        if (!done || !context.mounted) return;
        NoteMessage.showSuccessSnackBar(message: accept ? s.absenceAccepted : s.absenceRejected, context: context);
        meetingCubit.getData(newData: true);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Column(
      crossAxisAlignment: .stretch,
      children: [
        Row(
          children: [
            InitialsAvatar(name: item.name, size: 36),
            10.0.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  DrawableText(
                    text: item.name,
                    size: 14.0.sp,
                    fontWeight: .w700,
                    color: AppColorManager.neutral900,
                    maxLines: 2,
                  ),
                  if (item.date != null)
                    DrawableText(text: item.date!.formatDate, size: 12.0.sp, color: AppColorManager.neutral500),
                ],
              ),
            ),
            8.0.horizontalSpace,
            StatusChip(colors: status.colors, label: status.label),
          ],
        ),
        if (item.reason.isNotEmpty) ...[
          8.0.verticalSpace,
          DrawableText(text: item.reason, size: 13.0.sp, color: AppColorManager.neutral700, maxLines: 5),
        ],
        if (status == AbsenceStatus.pending) ...[
          10.0.verticalSpace,
          Row(
            children: [
              Expanded(
                child: MyButton(
                  variant: .dangerSoft,
                  size: .medium,
                  enable: !busy,
                  text: s.reject,
                  onTap: () => _answer(context, accept: false),
                ),
              ),
              8.0.horizontalSpace,
              Expanded(
                child: MyButton(
                  variant: .tonal,
                  size: .medium,
                  loading: busy,
                  text: s.acceptAbsence,
                  onTap: () => _answer(context, accept: true),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
