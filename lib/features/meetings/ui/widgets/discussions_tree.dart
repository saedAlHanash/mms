import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/widgets/small_widgets.dart';
import 'package:mms/core/widgets/status_chip.dart';
import 'package:mms/features/agendas/bloc/add_comment_cubit/add_comment_cubit.dart';
import 'package:mms/features/meetings/data/response/meetings_response.dart';
import 'package:mms/features/meetings/ui/widgets/comment_discussion_btn.dart';

/// Meeting discussions in one card: topic, status + date, my comment.
class DiscussionsTree extends StatelessWidget {
  const DiscussionsTree({super.key, required this.discussions});

  final List<Discussion> discussions;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    for (var i = 0; i < discussions.length; i++) {
      if (i > 0) children.add(const Divider(height: 1, color: AppColorManager.neutral50));
      children.add(_DiscussionRow(discussion: discussions[i]));
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

class _DiscussionRow extends StatelessWidget {
  const _DiscussionRow({required this.discussion});

  final Discussion discussion;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCommentCubit, AddCommentInitial>(
      buildWhen: (p, c) => c.done && c.request.discussionId == discussion.id,
      builder: (context, _) {
        final myComment = discussion.myComment;

        return Padding(
          padding: EdgeInsets.all(14.0.r),
          child: Row(
            crossAxisAlignment: .start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    DrawableText(
                      text: discussion.topic,
                      size: 15.0.sp,
                      fontWeight: .w600,
                      color: AppColorManager.neutral900,
                      matchParent: true,
                    ),
                    6.0.verticalSpace,
                    Row(
                      children: [
                        StatusChip.discussion(discussion.status),
                        if (discussion.date != null) ...[
                          8.0.horizontalSpace,
                          Directionality(
                            textDirection: .ltr,
                            child: DrawableText(
                              text: discussion.date!.formatDate,
                              size: 13.0.sp,
                              color: AppColorManager.neutral500,
                            ),
                          ),
                        ],
                      ],
                    ),
                    if (myComment != null) ...[
                      8.0.verticalSpace,
                      CommentBubble(text: myComment.text),
                    ],
                  ],
                ),
              ),
              8.0.horizontalSpace,
              CommentDiscussionBtn(discussion: discussion),
            ],
          ),
        );
      },
    );
  }
}
