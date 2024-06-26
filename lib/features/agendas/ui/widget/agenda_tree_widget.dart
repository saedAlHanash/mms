import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:animated_tree_view/tree_view/tree_view.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/widgets/expansion/tree_widget.dart';
import 'package:mms/core/widgets/my_card_widget.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../data/response/agendas_response.dart';
import 'agendas_list_widget.dart';
import 'comment_btn.dart';

class AgendaTreeWidget extends StatelessWidget {
  const AgendaTreeWidget({super.key, required this.treeNode});

  final TreeNode<Agenda> treeNode;

  @override
  Widget build(BuildContext context) {
    return TreeWidget<Agenda>(
      treeNode: treeNode,
      builder: (node) {
        if (node.isRoot) {
          return MyCardWidget(
            padding: const EdgeInsets.all( 30.0).r,
            child: DrawableText(
              fontWeight: FontWeight.bold,
              size: 18.0.sp,
              text: '${S.of(context).agendas} (${node.length})',
              matchParent: true,
            ),
          );
        }
        return Column(
          children: [
            MyCardWidget(
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0).r,
              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0).r,

              child: ListTile(
                contentPadding: EdgeInsetsDirectional.only(start: 10.0.w),
                title: DrawableText(
                  text: node.data!.title,
                  fontFamily: FontManager.cairoBold.name,
                ),
                subtitle: Column(
                  children: [
                    5.0.verticalSpace,
                    DrawableText(
                      text: node.data!.description,
                      color: Colors.grey,
                      matchParent: true,
                    ),
                    if (node.data!.myComment != null) 10.0.verticalSpace,
                    if (node.data!.myComment != null)
                      DrawableText(
                        text:
                            '(${node.data!.myComment!.party.name})  ${node.data!.myComment!.text}',
                        matchParent: true,
                        drawablePadding: 10.0.w,
                        drawableStart: ImageMultiType(
                          url: Assets.iconsComment,
                          color: node.data!.myComment!.isMyComment
                              ? AppColorManager.mainColor
                              : Colors.black,
                        ),
                      ),
                  ],
                ),
                trailing: CommentBtn(agenda: node.data!),
              ),
            ),
          ],
        );
      },
    );
  }
}
