import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/widgets/expansion/tree_widget.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../data/response/meetings_response.dart';
import 'comment_discussion_btn.dart';

class DiscussionsTree extends StatelessWidget {
  const DiscussionsTree({super.key, required this.treeNode});
  final TreeNode<Discussion> treeNode;
  @override
  Widget build(BuildContext context) {
    return TreeWidget<Discussion>(
      treeNode: treeNode,
      builder: (node) {
        if (node.isRoot) {
          return MyCardWidget(
            padding: const EdgeInsets.all(30.0).r,
            child: DrawableText(
              fontWeight: FontWeight.bold,
              size: 18.0.sp,
              text: '${S.of(context).discussions} (${node.length})',
              matchParent: true,
            ),
          );
        }
        return MyCardWidget(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0).r,
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0).r,
          child: ListTile(
            contentPadding: EdgeInsetsDirectional.only(start: 10.0.w),
            title: DrawableText(
              text: node.data!.topic,
              fontWeight: FontWeight.bold,
            ),
            subtitle: Column(
              children: [
                5.0.verticalSpace,
                DrawableText(
                  text: node.data!.meetingId,
                  color: Colors.grey,
                  matchParent: true,
                ),
                if (node.data!.myComment != null) 10.0.verticalSpace,
                if (node.data!.myComment != null)
                  DrawableText(
                    text: '(${node.data!.myComment!.party.name})  ${node.data!.myComment!.text}',
                    matchParent: true,
                    drawablePadding: 10.0.w,
                    drawableStart: ImageMultiType(
                      url: Assets.iconsComment,
                      color: node.data!.myComment!.isMyComment ? AppColorManager.mainColor : Colors.black,
                    ),
                  ),
              ],
            ),
            trailing: CommentDiscussionBtn(discussion: node.data!),
          ),
        );
      },
    );
  }
}
