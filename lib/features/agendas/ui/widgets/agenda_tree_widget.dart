import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/widgets/empty_state_widget.dart';
import 'package:mms/core/widgets/small_widgets.dart';
import 'package:mms/features/agendas/bloc/add_comment_cubit/add_comment_cubit.dart';
import 'package:mms/features/agendas/data/response/agendas_response.dart';
import 'package:mms/features/agendas/ui/widgets/comment_btn.dart';
import 'package:mms/features/agendas/ui/widgets/comment_sheet.dart';
import 'package:mms/features/interest/ui/widgets/interest_widgets.dart';
import 'package:mms/generated/l10n.dart';

/// Meeting agenda: all items in one card, sub-items nested under their parent
/// with "2.1" numbering, collapsible.
class AgendaTreeWidget extends StatelessWidget {
  const AgendaTreeWidget({super.key, required this.agendas, this.canDeclareInterest = true});

  final List<Agenda> agendas;

  /// Shows "Declare an interest" on each item (off on archived and canceled meetings).
  final bool canDeclareInterest;

  @override
  Widget build(BuildContext context) {
    if (agendas.isEmpty) {
      return EmptyStateWidget.card(
        icon: Icons.list_alt_rounded,
        title: S.of(context).noAgendaYet,
        description: S.of(context).noAgendaYetDescription,
      );
    }

    final children = <Widget>[];
    for (var i = 0; i < agendas.length; i++) {
      if (i > 0) children.add(const Divider(height: 1, color: AppColorManager.neutral50));
      children.add(_AgendaItem(agenda: agendas[i], number: '${i + 1}', canDeclareInterest: canDeclareInterest));
    }

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColorManager.neutral0,
        border: Border.all(color: AppColorManager.neutral100),
        borderRadius: BorderRadius.circular(12.0.r),
      ),
      child: Column(children: children),
    );
  }
}

/// Top-level agenda item (number box) with its nested sub-items.
class _AgendaItem extends StatefulWidget {
  const _AgendaItem({required this.agenda, required this.number, required this.canDeclareInterest});

  final Agenda agenda;
  final String number;
  final bool canDeclareInterest;

  @override
  State<_AgendaItem> createState() => _AgendaItemState();
}

class _AgendaItemState extends State<_AgendaItem> {
  bool _open = true;

  @override
  Widget build(BuildContext context) {
    final agenda = widget.agenda;
    final subItems = agenda.childrenItems;

    return Padding(
      padding: EdgeInsets.all(14.0.r),
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          _AgendaRow(
            agenda: agenda,
            number: widget.number,
            leading: AgendaNumberBox(number: widget.number),
            titleSize: 15,
            canDeclareInterest: widget.canDeclareInterest,
            extra: subItems.isEmpty
                ? null
                : TextButton.icon(
                    onPressed: () => setState(() => _open = !_open),
                    style: TextButton.styleFrom(
                      minimumSize: Size(0, 44.0.h),
                      padding: EdgeInsets.zero,
                      foregroundColor: AppColorManager.primary600,
                    ),
                    icon: AnimatedRotation(
                      turns: _open ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: ImageMultiType(
                        url: Icons.keyboard_arrow_down_rounded,
                        width: 18.0.r,
                        height: 18.0.r,
                        color: AppColorManager.primary600,
                      ),
                    ),
                    label: DrawableText(
                      text: _open
                          ? S.of(context).hideSubItems(subItems.length)
                          : S.of(context).showSubItems(subItems.length),
                      size: 13.0.sp,
                      fontWeight: .w700,
                      color: AppColorManager.primary600,
                    ),
                  ),
          ),
          if (subItems.isNotEmpty)
            AnimatedSize(
              duration: const Duration(milliseconds: 200),
              alignment: AlignmentDirectional.topCenter,
              child: _open
                  ? Padding(
                      padding: EdgeInsets.only(top: 4.0.h),
                      child: _SubItems(
                        items: subItems,
                        parentNumber: widget.number,
                        canDeclareInterest: widget.canDeclareInterest,
                      ),
                    )
                  : const SizedBox(width: double.infinity),
            ),
        ],
      ),
    );
  }
}

/// Sub-items with a 2px start line, aligned with the parent's text.
class _SubItems extends StatelessWidget {
  const _SubItems({required this.items, required this.parentNumber, required this.canDeclareInterest});

  final List<Agenda> items;
  final String parentNumber;
  final bool canDeclareInterest;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 13.0.w),
      child: Container(
        padding: EdgeInsetsDirectional.only(start: 25.0.w),
        decoration: const BoxDecoration(
          border: BorderDirectional(start: BorderSide(color: AppColorManager.neutral100, width: 2)),
        ),
        child: Column(
          crossAxisAlignment: .stretch,
          children: [
            for (var i = 0; i < items.length; i++) ...[
              if (i > 0) 12.0.verticalSpace,
              _SubItem(
                agenda: items[i],
                number: '$parentNumber.${i + 1}',
                canDeclareInterest: canDeclareInterest,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SubItem extends StatelessWidget {
  const _SubItem({required this.agenda, required this.number, required this.canDeclareInterest});

  final Agenda agenda;
  final String number;
  final bool canDeclareInterest;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .stretch,
      children: [
        _AgendaRow(
          agenda: agenda,
          number: number,
          titleSize: 14,
          canDeclareInterest: canDeclareInterest,
          leading: Directionality(
            textDirection: .ltr,
            child: DrawableText(
              text: number,
              size: 13.0.sp,
              fontWeight: .w700,
              color: AppColorManager.primary700,
            ),
          ),
        ),
        if (agenda.childrenItems.isNotEmpty) ...[
          8.0.verticalSpace,
          _SubItems(items: agenda.childrenItems, parentNumber: number, canDeclareInterest: canDeclareInterest),
        ],
      ],
    );
  }
}

/// leading + title/description (+ extra, + my comment) + comment button.
/// Rebuilds when my comment on this item is added.
class _AgendaRow extends StatelessWidget {
  const _AgendaRow({
    required this.agenda,
    required this.number,
    required this.leading,
    required this.titleSize,
    required this.canDeclareInterest,
    this.extra,
  });

  final Agenda agenda;
  final String number;
  final Widget leading;
  final double titleSize;
  final bool canDeclareInterest;
  final Widget? extra;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCommentCubit, AddCommentInitial>(
      buildWhen: (p, c) => c.done && c.request.agendaItemId == agenda.id,
      builder: (context, _) {
        final myComment = agenda.myComment;

        return Row(
          crossAxisAlignment: .start,
          children: [
            leading,
            12.0.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  DrawableText(
                    text: agenda.title,
                    size: titleSize.sp,
                    fontWeight: .w600,
                    color: AppColorManager.neutral900,
                    matchParent: true,
                  ),
                  if (agenda.description.isNotEmpty) ...[
                    4.0.verticalSpace,
                    DrawableText(
                      text: agenda.description,
                      size: 13.0.sp,
                      color: AppColorManager.neutral500,
                      matchParent: true,
                    ),
                  ],
                  if (myComment != null) ...[
                    8.0.verticalSpace,
                    CommentBubble(text: myComment.text),
                  ],
                  InterestAction(agenda: agenda, number: number, canDeclare: canDeclareInterest),
                  ?extra,
                ],
              ),
            ),
            8.0.horizontalSpace,
            CommentBtn(agenda: agenda, number: number),
          ],
        );
      },
    );
  }
}
