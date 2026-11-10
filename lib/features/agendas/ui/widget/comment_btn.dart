import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/features/agendas/bloc/add_comment_cubit/add_comment_cubit.dart';
import 'package:mms/features/agendas/data/response/agendas_response.dart';
import 'package:mms/features/agendas/ui/widget/comment_sheet.dart';
import 'package:mms/features/meetings/bloc/meeting_cubit/meeting_cubit.dart';
import 'package:mms/generated/l10n.dart';

/// "Add comment" button for an agenda item. Hidden when I already commented.
class CommentBtn extends StatefulWidget {
  const CommentBtn({super.key, required this.agenda, this.deep = 0, this.number});

  final Agenda agenda;
  final int deep;

  /// Agenda numbering shown in the comment sheet ("2", "2.1"…).
  final String? number;

  @override
  State<CommentBtn> createState() => _CommentBtnState();
}

class _CommentBtnState extends State<CommentBtn> {
  var addComment = false;

  AddCommentCubit get cubit => context.read<AddCommentCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddCommentCubit, AddCommentInitial>(
      listenWhen: (p, c) => c.done && c.request.agendaItemId == widget.agenda.id,
      listener: (context, state) {
        setState(() {
          widget.agenda.comments.add(state.getAddedComment);
          addComment = false;
          context.read<MeetingCubit>().addComment(
                comment: state.getAddedComment,
                agendaId: widget.agenda.id,
              );
        });
      },
      child: (!widget.agenda.haveMyComment && !addComment)
          ? BlocBuilder<AddCommentCubit, AddCommentInitial>(
              buildWhen: (p, c) => c.request.agendaItemId == widget.agenda.id,
              builder: (context, state) {
                return AddCommentButton(
                  loading: state.statuses.loading && state.request.agendaItemId == widget.agenda.id,
                  onTap: () {
                    cubit.setAgendaId = widget.agenda.id;
                    CommentSheet.show(
                      context,
                      cubit: cubit,
                      contextLabel: S.of(context).agendaItem,
                      title: widget.agenda.title,
                      number: widget.number,
                    );
                  },
                );
              },
            )
          : 0.0.verticalSpace,
    );
  }
}
