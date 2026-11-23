import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/util/my_style.dart';
import 'package:mms/core/util/snack_bar_message.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/core/widgets/small_widgets.dart';
import 'package:mms/features/agendas/data/response/agendas_response.dart';
import 'package:mms/features/agendas/ui/widgets/comment_sheet.dart';
import 'package:mms/features/interest/bloc/meeting_interests_cubit/meeting_interests_cubit.dart';
import 'package:mms/features/interest/data/response/interest_response.dart';
import 'package:mms/generated/l10n.dart';

/// Under an agenda item: my declared interest (with withdraw), or the
/// "Declare an interest" action when [canDeclare].
class InterestAction extends StatelessWidget {
  const InterestAction({super.key, required this.agenda, required this.number, required this.canDeclare});

  final Agenda agenda;
  final String number;

  /// False on archived and canceled meetings.
  final bool canDeclare;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeetingInterestsCubit, MeetingInterestsInitial>(
      builder: (context, state) {
        final cubit = context.read<MeetingInterestsCubit>();
        final mine = cubit.mineFor(agenda.id);
        final sending = state.sendingItemId == agenda.id;

        if (mine != null) {
          return Padding(
            padding: EdgeInsets.only(top: 8.0.h),
            child: _DeclaredBadge(disclosure: mine, sending: sending, canWithdraw: canDeclare),
          );
        }
        if (!canDeclare) return const SizedBox.shrink();

        return Align(
          alignment: AlignmentDirectional.centerStart,
          child: TextButton.icon(
            onPressed: sending ? null : () => InterestSheet.show(context, cubit: cubit, agenda: agenda, number: number),
            style: TextButton.styleFrom(
              minimumSize: Size(0, 44.0.h),
              padding: EdgeInsets.zero,
              foregroundColor: AppColorManager.neutral500,
              tapTargetSize: MaterialTapTargetSize.padded,
            ),
            icon: sending
                ? SizedBox(
                    width: 16.0.r,
                    height: 16.0.r,
                    child: const CircularProgressIndicator(strokeWidth: 2, color: AppColorManager.neutral500),
                  )
                : ImageMultiType(
                    url: Icons.outlined_flag_rounded,
                    width: 18.0.r,
                    height: 18.0.r,
                    color: AppColorManager.neutral500,
                  ),
            label: DrawableText(
              text: S.of(context).declareInterest,
              size: 13.0.sp,
              fontWeight: .w600,
              color: AppColorManager.neutral500,
            ),
          ),
        );
      },
    );
  }
}

/// "You declared an interest in this item" + note + withdraw.
class _DeclaredBadge extends StatelessWidget {
  const _DeclaredBadge({required this.disclosure, required this.sending, required this.canWithdraw});

  final InterestDisclosure disclosure;
  final bool sending;
  final bool canWithdraw;

  Future<void> _confirmWithdraw(BuildContext context) async {
    final cubit = context.read<MeetingInterestsCubit>();
    await NoteMessage.showCheckDialog(
      context,
      text: S.of(context).withdrawInterestTitle,
      description: S.of(context).withdrawInterestDescription,
      textButton: S.of(context).withdrawInterest,
      image: Icons.outlined_flag_rounded,
      destructive: true,
      onConfirm: () => cubit.withdraw(disclosure),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(start: 12.0.w, end: 4.0.w, top: 10.0.h, bottom: 10.0.h),
      decoration: BoxDecoration(
        color: AppColorManager.warningSoft,
        borderRadius: BorderRadius.circular(10.0.r),
      ),
      child: Row(
        children: [
          ImageMultiType(
            url: Icons.flag_rounded,
            width: 18.0.r,
            height: 18.0.r,
            color: AppColorManager.warning,
          ),
          8.0.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                DrawableText(
                  text: S.of(context).interestDeclared,
                  size: 13.0.sp,
                  fontWeight: .w700,
                  color: AppColorManager.warningText,
                ),
                if (disclosure.note.isNotEmpty) ...[
                  2.0.verticalSpace,
                  DrawableText(
                    text: disclosure.note,
                    size: 12.0.sp,
                    color: AppColorManager.warningText,
                    maxLines: 3,
                  ),
                ],
              ],
            ),
          ),
          if (canWithdraw)
            sending
                ? SizedBox(
                    width: 44.0.r,
                    height: 44.0.r,
                    child: Center(
                      child: SizedBox(
                        width: 18.0.r,
                        height: 18.0.r,
                        child: const CircularProgressIndicator(strokeWidth: 2, color: AppColorManager.warning),
                      ),
                    ),
                  )
                : TextButton(
                    onPressed: () => _confirmWithdraw(context),
                    style: TextButton.styleFrom(
                      minimumSize: Size(44.0.r, 44.0.r),
                      padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                      foregroundColor: AppColorManager.warningText,
                    ),
                    child: DrawableText(
                      text: S.of(context).withdraw,
                      size: 13.0.sp,
                      fontWeight: .w700,
                      color: AppColorManager.warningText,
                    ),
                  ),
        ],
      ),
    );
  }
}

/// Bottom sheet to declare a conflict of interest, with an optional note.
class InterestSheet extends StatefulWidget {
  const InterestSheet({super.key, required this.agenda, required this.number});

  final Agenda agenda;
  final String number;

  static Future<void> show(
    BuildContext context, {
    required MeetingInterestsCubit cubit,
    required Agenda agenda,
    required String number,
  }) {
    return AppBottomSheet.show(
      context,
      child: BlocProvider.value(
        value: cubit,
        child: InterestSheet(agenda: agenda, number: number),
      ),
    );
  }

  @override
  State<InterestSheet> createState() => _InterestSheetState();
}

class _InterestSheetState extends State<InterestSheet> {
  static const _maxNote = 500;

  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final ok = await context.read<MeetingInterestsCubit>().declare(
      agendaItemId: widget.agenda.id,
      note: _controller.text,
    );
    if (ok && mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0.r),
      borderSide: const BorderSide(color: AppColorManager.neutral200),
    );

    return BlocBuilder<MeetingInterestsCubit, MeetingInterestsInitial>(
      builder: (context, state) {
        final sending = state.sendingItemId == widget.agenda.id;

        return Column(
          crossAxisAlignment: .stretch,
          mainAxisSize: .min,
          children: [
            Row(
              children: [
                Expanded(
                  child: DrawableText(
                    text: S.of(context).declareInterest,
                    size: 18.0.sp,
                    fontWeight: .w700,
                    color: AppColorManager.neutral900,
                  ),
                ),
                IconButton(
                  tooltip: S.of(context).close,
                  constraints: BoxConstraints(minWidth: 44.0.r, minHeight: 44.0.r),
                  onPressed: () => Navigator.pop(context),
                  icon: ImageMultiType(
                    url: Icons.close_rounded,
                    width: 22.0.r,
                    height: 22.0.r,
                    color: AppColorManager.neutral700,
                  ),
                ),
              ],
            ),
            8.0.verticalSpace,
            // Context card.
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 10.0.h),
              decoration: BoxDecoration(
                color: AppColorManager.neutral25,
                border: Border.all(color: AppColorManager.neutral50),
                borderRadius: BorderRadius.circular(10.0.r),
              ),
              child: Row(
                children: [
                  AgendaNumberBox(number: widget.number),
                  10.0.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      mainAxisSize: .min,
                      children: [
                        DrawableText(
                          text: S.of(context).agendaItem,
                          size: 12.0.sp,
                          color: AppColorManager.neutral500,
                        ),
                        DrawableText(
                          text: widget.agenda.title,
                          size: 14.0.sp,
                          fontWeight: .w600,
                          color: AppColorManager.neutral900,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            12.0.verticalSpace,
            // What it means.
            Container(
              padding: EdgeInsets.all(12.0.r),
              decoration: BoxDecoration(
                color: AppColorManager.warningSoft,
                borderRadius: BorderRadius.circular(10.0.r),
              ),
              child: DrawableText(
                text: S.of(context).declareInterestHint,
                size: 13.0.sp,
                color: AppColorManager.warningText,
                matchParent: true,
                drawablePadding: 8.0.w,
                drawableStart: ImageMultiType(
                  url: Icons.info_outline_rounded,
                  width: 18.0.r,
                  height: 18.0.r,
                  color: AppColorManager.warning,
                ),
              ),
            ),
            16.0.verticalSpace,
            DrawableText(
              text: S.of(context).interestNoteOptional,
              size: 14.0.sp,
              fontWeight: .w600,
              color: AppColorManager.neutral700,
            ),
            6.0.verticalSpace,
            SizedBox(
              height: 100.0.h,
              child: TextField(
                controller: _controller,
                expands: true,
                maxLines: null,
                maxLength: _maxNote,
                buildCounter: (_, {required currentLength, required isFocused, required maxLength}) => null,
                textAlignVertical: TextAlignVertical.top,
                onChanged: (_) => setState(() {}),
                style: MyStyle.bodyLg.copyWith(color: AppColorManager.neutral900),
                decoration: InputDecoration(
                  hintText: S.of(context).interestNoteHint,
                  hintStyle: MyStyle.bodyLg.copyWith(color: AppColorManager.neutral500),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 10.0.h),
                  border: border,
                  enabledBorder: border,
                  focusedBorder: border.copyWith(
                    borderSide: const BorderSide(color: AppColorManager.primary500, width: 2),
                  ),
                ),
              ),
            ),
            4.0.verticalSpace,
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Directionality(
                textDirection: .ltr,
                child: DrawableText(
                  text: '${_controller.text.length}/$_maxNote',
                  size: 12.0.sp,
                  color: AppColorManager.neutral500,
                ),
              ),
            ),
            12.0.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: MyButton(
                    width: double.infinity,
                    variant: .outline,
                    text: S.of(context).cancel,
                    onTap: () => Navigator.pop(context),
                  ),
                ),
                8.0.horizontalSpace,
                Expanded(
                  flex: 2,
                  child: MyButton(
                    width: double.infinity,
                    text: S.of(context).declare,
                    loading: sending,
                    onTap: _submit,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
