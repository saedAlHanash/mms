import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/core/util/snack_bar_message.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/core/widgets/my_card_widget.dart';
import 'package:mms/core/widgets/status_chip.dart';
import 'package:mms/features/agenda_request/bloc/my_agenda_requests_cubit/my_agenda_requests_cubit.dart';
import 'package:mms/features/agenda_request/data/response/agenda_request_response.dart';
import 'package:mms/features/agenda_request/ui/widgets/propose_item_sheet.dart';
import 'package:mms/features/meetings/data/response/meetings_response.dart';
import 'package:mms/generated/l10n.dart';

/// "Propose an item" + my proposals with their status, on the meeting page.
class AgendaRequestsSection extends StatelessWidget {
  const AgendaRequestsSection({super.key, required this.meeting});

  final Meeting meeting;

  /// Proposals are open while the meeting is planned or scheduled (the server
  /// also closes them once the agenda is published: `agenda_requests_closed`).
  static bool canPropose(Meeting meeting) =>
      meeting.status == MeetingStatus.planned || meeting.status == MeetingStatus.scheduled;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyAgendaRequestsCubit, MyAgendaRequestsInitial>(
      builder: (context, state) {
        final open = canPropose(meeting);
        final mine = state.result;
        if (!open && mine.isEmpty) return const SizedBox.shrink();

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
                    Container(
                      width: 44.0.r,
                      height: 44.0.r,
                      alignment: .center,
                      decoration: BoxDecoration(
                        color: AppColorManager.primary50,
                        borderRadius: BorderRadius.circular(12.0.r),
                      ),
                      child: ImageMultiType(
                        url: Icons.post_add_rounded,
                        width: 24.0.r,
                        height: 24.0.r,
                        color: AppColorManager.primary500,
                      ),
                    ),
                    12.0.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          DrawableText(
                            text: S.of(context).agendaProposals,
                            size: 15.0.sp,
                            fontWeight: .w700,
                            color: AppColorManager.neutral900,
                          ),
                          2.0.verticalSpace,
                          DrawableText(
                            text: open ? S.of(context).agendaProposalsHint : S.of(context).agendaProposalsClosed,
                            size: 13.0.sp,
                            color: AppColorManager.neutral500,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (open) ...[
                  14.0.verticalSpace,
                  MyButton(
                    variant: .tonal,
                    size: .medium,
                    width: double.infinity,
                    text: S.of(context).proposeItem,
                    startIcon: ImageMultiType(
                      url: Icons.add_rounded,
                      width: 20.0.r,
                      height: 20.0.r,
                      color: AppColorManager.primary600,
                    ),
                    onTap: () => ProposeItemSheet.show(
                      context,
                      cubit: context.read<MyAgendaRequestsCubit>(),
                      meetingId: meeting.id,
                    ),
                  ),
                ],
                if (mine.isNotEmpty) ...[
                  16.0.verticalSpace,
                  DrawableText(
                    text: S.of(context).myProposals(mine.length),
                    size: 12.0.sp,
                    fontWeight: .w600,
                    color: AppColorManager.neutral500,
                  ),
                  for (final item in mine) ...[
                    const Divider(height: 24, color: AppColorManager.neutral100),
                    _ProposalRow(item: item, deleting: state.deletingId == item.id),
                  ],
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ProposalRow extends StatelessWidget {
  const _ProposalRow({required this.item, required this.deleting});

  final AgendaItemRequest item;
  final bool deleting;

  Future<void> _confirmWithdraw(BuildContext context) async {
    final cubit = context.read<MyAgendaRequestsCubit>();
    await NoteMessage.showCheckDialog(
      context,
      text: S.of(context).withdrawProposalTitle,
      description: item.title,
      textButton: S.of(context).withdrawProposal,
      image: Icons.delete_outline_rounded,
      destructive: true,
      onConfirm: () => cubit.delete(item.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .stretch,
      children: [
        Row(
          crossAxisAlignment: .start,
          children: [
            Expanded(
              child: DrawableText(
                text: item.title,
                size: 14.0.sp,
                fontWeight: .w600,
                color: AppColorManager.neutral900,
                maxLines: 3,
              ),
            ),
            8.0.horizontalSpace,
            StatusChip(colors: item.status.colors, label: item.status.label),
          ],
        ),
        if (item.note.isNotEmpty) ...[
          4.0.verticalSpace,
          DrawableText(text: item.note, size: 13.0.sp, color: AppColorManager.neutral500, maxLines: 3),
        ],
        if (item.hasAttachment && item.mediaOriginalFileName.isNotEmpty) ...[
          6.0.verticalSpace,
          DrawableText(
            text: item.mediaOriginalFileName,
            size: 12.0.sp,
            color: AppColorManager.neutral700,
            maxLines: 1,
            drawablePadding: 4.0.w,
            drawableStart: ImageMultiType(
              url: Icons.attach_file_rounded,
              width: 16.0.r,
              height: 16.0.r,
              color: AppColorManager.neutral500,
            ),
          ),
        ],
        if (item.status == AgendaRequestStatus.rejected && item.reason.isNotEmpty) ...[
          8.0.verticalSpace,
          Container(
            padding: EdgeInsets.all(10.0.r),
            decoration: BoxDecoration(
              color: AppColorManager.dangerSoft,
              borderRadius: BorderRadius.circular(10.0.r),
            ),
            child: DrawableText(
              text: '${S.of(context).rejectionReason}: ${item.reason}',
              size: 13.0.sp,
              color: AppColorManager.dangerText,
              matchParent: true,
            ),
          ),
        ],
        if (item.status == AgendaRequestStatus.pending) ...[
          8.0.verticalSpace,
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: MyButton(
              variant: .dangerSoft,
              size: .medium,
              width: 140.0.w,
              loading: deleting,
              text: S.of(context).withdrawProposal,
              onTap: () => _confirmWithdraw(context),
            ),
          ),
        ],
      ],
    );
  }
}
