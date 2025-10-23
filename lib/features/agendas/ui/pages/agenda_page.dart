import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/widgets/app_bar/app_bar_widget.dart';
import 'package:mms/features/agendas/data/response/agendas_response.dart';
import 'package:mms/features/agendas/ui/widget/comment_btn.dart';

import '../../../../generated/assets.dart';

//
// final tree = TreeNode<Agenda>.root(data: Agenda())
//   ..addAll([
//     TreeNode(data: Agenda())
//       ..addAll([
//         TreeNode(
//           data: Agenda(),
//         ),
//         TreeNode(
//           data: Agenda(),
//         ),
//         TreeNode(
//           data: Agenda(),
//         )
//       ]),
//     TreeNode(data: Agenda())
//       ..addAll([
//         TreeNode(data: Agenda())
//           ..addAll([
//             TreeNode(data: Agenda()),
//             TreeNode(data: Agenda()),
//             TreeNode(data: Agenda()),
//             TreeNode(data: Agenda()),
//             TreeNode(data: Agenda()),
//             TreeNode(data: Agenda()),
//             TreeNode(data: Agenda()),
//             TreeNode(data: Agenda()),
//             TreeNode(data: Agenda()),
//             TreeNode(data: Agenda()),
//             TreeNode(data: Agenda()),
//             TreeNode(data: Agenda()),
//             TreeNode(data: Agenda()),
//             TreeNode(data: Agenda()),
//             TreeNode(data: Agenda()),
//             TreeNode(data: Agenda()),
//             TreeNode(data: Agenda()),
//           ]),
//         TreeNode(data: Agenda())
//           ..addAll([
//             TreeNode(data: Agenda())
//               ..addAll([
//                 TreeNode(
//                     data: Agenda()),
//                 TreeNode(
//                     data: Agenda()),
//               ]),
//             TreeNode(data: Agenda())
//               ..addAll([
//                 TreeNode(data: Agenda()),
//                 TreeNode(data: Agenda()),
//               ])
//           ])
//       ]),
//     TreeNode(data: Agenda())
//       ..addAll([
//         TreeNode(data: Agenda()),
//         TreeNode(data: Agenda())
//           ..addAll([
//             TreeNode(
//               data: Agenda(),
//             ),
//             TreeNode(
//               data: Agenda(),
//             ),
//             TreeNode(
//               data: Agenda(),
//             ),
//           ]),
//         TreeNode(
//           data: Agenda(),
//         ),
//         TreeNode(
//           data: Agenda(),
//         )
//       ]),
//   ]);

class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key, required this.agenda});

  final Agenda agenda;

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  late TreeNode<Agenda> getTree;

  List<Node> it(Agenda agenda) {
    final list = <Node>[];

    if (agenda.childrenItems.isEmpty) {
      list.add(TreeNode(data: agenda));
      return list;
    }
    for (var e in agenda.childrenItems) {
      list.addAll(it(e));
    }

    return list;
  }

  @override
  void initState() {
    getTree = TreeNode<Agenda>.root(data: widget.agenda)
      ..addAll(it(widget.agenda));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        titleText: widget.agenda.title,
      ),
      body: TreeView.simpleTyped<Agenda, TreeNode<Agenda>>(
        tree: getTree,
        showRootNode: true,
        expansionBehavior: ExpansionBehavior.scrollToLastChild,
        expansionIndicatorBuilder: (context, node) {
          if (node.isRoot) {
            return PlusMinusIndicator(
              tree: node,
              alignment: Alignment.centerLeft,
              color: Colors.grey[700],
            );
          }

          return ChevronIndicator.rightDown(
            tree: node,
            alignment: Alignment.centerLeft,
            color: Colors.grey[700],
          );
        },
        indentation: const Indentation(),
        builder: (context, node) {
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 40.0).r,
                padding: const EdgeInsets.symmetric(horizontal: 20.0).r,
                decoration: BoxDecoration(
                  color: AppColorManager.getColor(1),
                  borderRadius: BorderRadius.circular(8.0.r),
                ),
                child: ListTile(
                  contentPadding: EdgeInsetsDirectional.only(start: 20.0.w),
                  title: DrawableText(
                    text: node.data!.title,
                    size: 18.0.sp,
                   fontWeight: FontWeight.bold,
                  ),
                  subtitle: Column(
                    children: [
                      5.0.verticalSpace,
                      DrawableText(
                        text: node.data!.description,
                        color: Colors.grey,
                        matchParent: true,
                      ),
                      if(node.data!.myComment!=null)
                        10.0.verticalSpace,
                      if(node.data!.myComment!=null)
                      DrawableText(
                        text: '(${node.data!.myComment!.party.name})  ${node.data!.myComment!.text}',
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
      ),
    );
  }
}

