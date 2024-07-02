import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:animated_tree_view/tree_view/tree_view.dart';
import 'package:animated_tree_view/tree_view/widgets/expansion_indicator.dart';
import 'package:animated_tree_view/tree_view/widgets/indent.dart';
import 'package:flutter/material.dart';
import 'package:mms/core/strings/app_color_manager.dart';

typedef TreeWidgetBuilder<T> = Widget Function(TreeNode<T> node);

class TreeWidget<T> extends StatelessWidget {
  const TreeWidget({super.key, required this.treeNode, required this.builder});

  final TreeNode<T> treeNode;
  final TreeWidgetBuilder<T> builder;

  @override
  Widget build(BuildContext context) {
    return TreeView.simpleTyped<T, TreeNode<T>>(
      tree: treeNode,
      focusToNewNode: false,
      expansionBehavior: ExpansionBehavior.snapToTop,
      expansionIndicatorBuilder: (context, node) {
        return ChevronIndicator.rightDown(
          tree: node,
          alignment: Alignment.centerLeft,
          color: AppColorManager.mainColor,
        );
      },
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      indentation:  Indentation(
        color: Colors.grey[500]!,
        style: IndentStyle.roundJoint,
      ),
      builder: (context, node) => builder.call(node),
    );
  }
}
