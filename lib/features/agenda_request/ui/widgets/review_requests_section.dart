import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/helper/launcher_helper.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/core/util/snack_bar_message.dart';
import 'package:mms/core/widgets/icon_tile.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/core/widgets/my_card_widget.dart';
import 'package:mms/core/widgets/reason_sheet.dart';
import 'package:mms/core/widgets/small_widgets.dart';
import 'package:mms/core/widgets/status_chip.dart';
import 'package:mms/features/agenda_request/bloc/review_agenda_requests_cubit/review_agenda_requests_cubit.dart';
import 'package:mms/features/agenda_request/data/response/agenda_request_response.dart';
import 'package:mms/features/agendas/data/response/agendas_response.dart';
import 'package:mms/features/meetings/data/response/meetings_response.dart';
import 'package:mms/generated/l10n.dart';

/// The secretary's review of everyone's agenda proposals for this meeting.
class ReviewRequestsSection extends StatelessWidget {
  const ReviewRequestsSection({super.key, required this.meeting});

  final Meeting meeting;

  static bool showsFor(Meeting meeting) => meeting.callerMembershipType == MembershipType.secretary;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewAgendaRequestsCubit, ReviewAgendaRequestsInitial>(
      builder: (context, state) {
        final list = state.result;
        if (list.isEmpty) return const SizedBox.shrink();

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
                    const IconTile(icon: Icons.fact_check_outlined, size: 44),
                    12.0.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          DrawableText(
                            text: S.of(context).reviewProposals,
                            size: 15.0.sp,
                            fontWeight: .w700,
                            color: AppColorManager.neutral900,
                          ),
                          2.0.verticalSpace,
                          DrawableText(
                            text: S.of(context).reviewProposalsHint,
                            size: 13.0.sp,
                            color: AppColorManager.neutral500,
                          ),
                        ],
                      ),
                    ),
                    if (state.pendingCount > 0)
                      StatusChip(
                        colors: AgendaRequestStatus.pending.colors,
                        label: S.of(context).pendingCount(state.pendingCount),
                      ),
                  ],
                ),
                for (final item in list) ...[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Divider(height: 1, color: AppColorManager.neutral100),
                  ),
                  _ReviewItem(item: item, meeting: meeting, busy: state.busyId == item.id),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ReviewItem extends StatelessWidget {
  const _ReviewItem({required this.item, required this.meeting, required this.busy});

  final AgendaItemRequest item;
  final Meeting meeting;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final cubit = context.read<ReviewAgendaRequestsCubit>();
    final pending = item.status == AgendaRequestStatus.pending;

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
                fontWeight: .w700,
                color: AppColorManager.neutral900,
                maxLines: 3,
              ),
            ),
            8.0.horizontalSpace,
            StatusChip(colors: item.status.colors, label: item.status.label),
          ],
        ),
        4.0.verticalSpace,
        DrawableText(
          text: item.created == null
              ? item.proposerName
              : '${item.proposerName} · ${item.created!.formatDate}',
          size: 12.0.sp,
          color: AppColorManager.neutral500,
        ),
        if (item.note.isNotEmpty) ...[
          6.0.verticalSpace,
          DrawableText(text: item.note, size: 13.0.sp, color: AppColorManager.neutral700, maxLines: 4),
        ],
        if (item.mediaSavedPath.isNotEmpty) ...[
          6.0.verticalSpace,
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: MyButton(
              variant: .text,
              size: .small,
              text: item.mediaOriginalFileName.isEmpty ? s.attachment : item.mediaOriginalFileName,
              startIcon: ImageMultiType(
                url: Icons.attach_file_rounded,
                width: 16.0.r,
                height: 16.0.r,
                color: AppColorManager.primary500,
              ),
              onTap: () => LauncherHelper.openPage(item.mediaSavedPath),
            ),
          ),
        ],
        if (item.status == AgendaRequestStatus.rejected && item.reason.isNotEmpty) ...[
          6.0.verticalSpace,
          DrawableText(
            text: '${s.rejectionReason}: ${item.reason}',
            size: 13.0.sp,
            color: AppColorManager.dangerText,
          ),
        ],
        if (pending) ...[
          10.0.verticalSpace,
          Row(
            children: [
              Expanded(
                child: MyButton(
                  variant: .dangerSoft,
                  size: .medium,
                  enable: !busy,
                  text: s.reject,
                  onTap: () async {
                    final reason = await ReasonSheet.show(
                      context,
                      title: s.rejectProposalTitle,
                      description: item.title,
                      hint: s.rejectProposalHint,
                      confirmText: s.reject,
                      destructive: true,
                    );
                    if (reason == null || reason.isEmpty) return;
                    final ok = await cubit.reject(item.id, reason: reason);
                    if (ok && context.mounted) {
                      NoteMessage.showSuccessSnackBar(message: s.proposalRejected, context: context);
                    }
                  },
                ),
              ),
              8.0.horizontalSpace,
              Expanded(
                child: MyButton(
                  variant: .tonal,
                  size: .medium,
                  loading: busy,
                  text: s.acceptProposal,
                  onTap: () => _accept(context),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Future<void> _accept(BuildContext context) async {
    final s = S.of(context);
    final cubit = context.read<ReviewAgendaRequestsCubit>();
    final items = _flatten(meeting.agendaItems);
    if (items.isEmpty) {
      NoteMessage.showErrorSnackBar(message: s.acceptNeedsAgendaItem, context: context);
      return;
    }
    final agendaItemId = await AppBottomSheet.show<String>(
      context,
      child: _AgendaPicker(items: items, proposal: item),
    );
    if (agendaItemId == null) return;
    final ok = await cubit.accept(item.id, agendaItemId: agendaItemId);
    if (ok && context.mounted) NoteMessage.showSuccessSnackBar(message: s.proposalAccepted, context: context);
  }

  static List<Agenda> _flatten(List<Agenda> items) => [
    for (final e in items) ...[e, ..._flatten(e.childrenItems)],
  ];
}

/// Pick the agenda item (already created on the web) that this proposal became.
class _AgendaPicker extends StatelessWidget {
  const _AgendaPicker({required this.items, required this.proposal});

  final List<Agenda> items;
  final AgendaItemRequest proposal;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7),
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .stretch,
        children: [
          DrawableText(
            text: S.of(context).acceptProposalTitle,
            size: 17.0.sp,
            fontWeight: .w700,
            color: AppColorManager.neutral900,
          ),
          4.0.verticalSpace,
          DrawableText(text: S.of(context).acceptProposalHint, size: 13.0.sp, color: AppColorManager.neutral500),
          12.0.verticalSpace,
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: items.length,
              separatorBuilder: (_, _) => const Divider(height: 1, color: AppColorManager.neutral100),
              itemBuilder: (context, i) {
                final agenda = items[i];
                final same = agenda.title.trim() == proposal.title.trim();
                return InkWell(
                  onTap: () => Navigator.pop(context, agenda.id),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: 52.0.h),
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: agenda.parentId.isEmpty ? 0 : 16.0.w,
                        top: 10.0.h,
                        bottom: 10.0.h,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: DrawableText(
                              text: agenda.title,
                              size: 14.0.sp,
                              fontWeight: same ? .w700 : .w500,
                              color: AppColorManager.neutral900,
                              maxLines: 2,
                            ),
                          ),
                          if (same)
                            ImageMultiType(
                              url: Icons.auto_awesome_outlined,
                              width: 18.0.r,
                              height: 18.0.r,
                              color: AppColorManager.primary500,
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
