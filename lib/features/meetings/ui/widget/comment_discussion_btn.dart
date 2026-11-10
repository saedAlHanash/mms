import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/features/agendas/bloc/add_comment_cubit/add_comment_cubit.dart';
import 'package:mms/features/agendas/ui/widget/comment_sheet.dart';
import 'package:mms/features/meetings/bloc/meeting_cubit/meeting_cubit.dart';
import 'package:mms/features/meetings/data/response/meetings_response.dart';
import 'package:mms/generated/l10n.dart';

/// "Add comment" button for a discussion. Hidden when I already commented.
class CommentDiscussionBtn extends StatefulWidget {
  const CommentDiscussionBtn({super.key, required this.discussion});

  final Discussion discussion;

  @override
  State<CommentDiscussionBtn> createState() => _CommentDiscussionBtnState();
}

class _CommentDiscussionBtnState extends State<CommentDiscussionBtn> {
  var addComment = false;

  AddCommentCubit get cubit => context.read<AddCommentCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddCommentCubit, AddCommentInitial>(
      listenWhen: (p, c) => c.done && c.request.discussionId == widget.discussion.id,
      listener: (context, state) {
        setState(() {
          widget.discussion.comments.add(state.getAddedDiscussionComment);
          addComment = false;
          context.read<MeetingCubit>().addDiscussionComment(
                comment: state.getAddedDiscussionComment,
                discussionId: widget.discussion.id,
              );
        });
      },
      child: (!widget.discussion.haveMyComment && !addComment)
          ? BlocBuilder<AddCommentCubit, AddCommentInitial>(
              buildWhen: (p, c) => c.request.discussionId == widget.discussion.id,
              builder: (context, state) {
                return AddCommentButton(
                  loading: state.statuses.loading && state.request.discussionId == widget.discussion.id,
                  onTap: () {
                    cubit.setDiscussionId = widget.discussion.id;
                    CommentSheet.show(
                      context,
                      cubit: cubit,
                      contextLabel: S.of(context).discussion,
                      title: widget.discussion.topic,
                    );
                  },
                );
              },
            )
          : 0.0.verticalSpace,
    );
  }
}
