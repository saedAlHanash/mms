import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/core/util/snack_bar_message.dart';
import 'package:mms/core/widgets/icon_tile.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/core/widgets/my_card_widget.dart';
import 'package:mms/core/widgets/reason_sheet.dart';
import 'package:mms/core/widgets/status_chip.dart';
import 'package:mms/features/meetings/bloc/add_absence_cubit/add_absence_cubit.dart';
import 'package:mms/features/meetings/data/response/meetings_response.dart';
import 'package:mms/generated/l10n.dart';

/// A member asking to be excused from a scheduled meeting, or the state of their
/// request (the chair accepts or rejects it). Like the web, members only.
class AbsentWidget extends StatelessWidget {
  const AbsentWidget({super.key, required this.meeting});

  final Meeting meeting;

  static bool showsFor(Meeting meeting) =>
      meeting.status == MeetingStatus.scheduled && !(meeting.callerMembershipType?.isLead ?? false);

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final me = AppProvider.getParty.id;
    final mine = meeting.absenceRequests.where((e) => e.party?.id == me).lastOrNull;
    final status = mine?.absenceStatus ?? (meeting.hasRequestAbsence ? AbsenceStatus.pending : null);

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
                const IconTile(icon: Icons.event_busy_outlined, size: 44, tone: .neutral),
                12.0.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      DrawableText(
                        text: status == null ? s.cantAttend : s.yourAbsenceRequest,
                        size: 15.0.sp,
                        fontWeight: .w700,
                        color: AppColorManager.neutral900,
                      ),
                      2.0.verticalSpace,
                      DrawableText(
                        text: switch (status) {
                          null => s.cantAttendHint,
                          AbsenceStatus.pending => s.absenceWaitingChair,
                          AbsenceStatus.accepted => s.absenceExcusedHint,
                          AbsenceStatus.rejected => s.absenceRejectedHint,
                        },
                        size: 13.0.sp,
                        color: AppColorManager.neutral500,
                      ),
                    ],
                  ),
                ),
                if (status != null) ...[
                  8.0.horizontalSpace,
                  StatusChip(colors: status.colors, label: status.label),
                ],
              ],
            ),
            if (mine != null && mine.reason.isNotEmpty) ...[
              10.0.verticalSpace,
              DrawableText(text: mine.reason, size: 13.0.sp, color: AppColorManager.neutral700, maxLines: 4),
            ],
            if (status == null) ...[
              12.0.verticalSpace,
              BlocBuilder<AddAbsenceCubit, AddAbsenceInitial>(
                builder: (context, state) {
                  return MyButton(
                    variant: .outline,
                    size: .medium,
                    width: double.infinity,
                    loading: state.statuses == CubitStatuses.loading,
                    text: s.requestAbsenceAction,
                    onTap: () => _request(context),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _request(BuildContext context) async {
    final s = S.of(context);
    final cubit = context.read<AddAbsenceCubit>();
    final reason = await ReasonSheet.show(
      context,
      title: s.requestAbsenceTitle,
      description: meeting.title,
      hint: s.requestAbsenceHint,
      confirmText: s.sendRequest,
      maxLength: 500,
    );
    if (reason == null || reason.isEmpty) return;
    if (await cubit.addAbsence(meetingId: meeting.id, comment: reason) && context.mounted) {
      NoteMessage.showSuccessSnackBar(message: s.absenceRequestSent, context: context);
    }
  }
}
