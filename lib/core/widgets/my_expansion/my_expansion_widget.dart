import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/widgets/my_expansion/my_expansion_panal.dart';

import 'item_expansion.dart';

class MyExpansionWidget extends StatefulWidget {
  const MyExpansionWidget({
    super.key,
    required this.items,
    this.onTapItem,
    this.elevation,
    this.onExpansion,
    this.decoration,
  });

  final List<ItemExpansion> items;
  final double? elevation;
  final BoxDecoration? decoration;
  final Function(int)? onTapItem;
  final Function(int panelIndex, bool isExpanded)? onExpansion;

  @override
  State<MyExpansionWidget> createState() => _MyExpansionWidgetState();
}

class _MyExpansionWidgetState extends State<MyExpansionWidget> {
  @override
  Widget build(BuildContext context) {
    final listItem = widget.items.map(
      (e) {
        return MyExpansionPanel(
          canTapOnHeader: true,
          isExpanded: e.isExpanded,
          withSideColor: e.withSideColor,
          backgroundColor: (e.isExpanded && e.withSideColor)
              ? AppColorManager.lightGray
              : AppColorManager.whit,
          headerBuilder: (_, isExpanded) {
            if (e.headerText != null) {
              return DrawableText(
                text: e.headerText!,
                fontFamily: FontManager.cairoBold.name,
                color: Colors.black,
                drawablePadding: 10.0.w,
              );
            }
            return e.header ?? const DrawableText(text: 'header');
          },
          body: e.body,
          enable: e.enable,
          onTapItem: widget.onTapItem,
        );
      },
    ).toList();

    return MyExpansionPanelList(
      elevation: 0.0,
      cardElevation: 0,
      children: listItem,
      decoration: widget.decoration,
      dividerColor: Colors.transparent,
      expandedHeaderPadding: EdgeInsets.zero,
      expansionCallback: (panelIndex, isExpanded) {
        widget.onExpansion?.call(panelIndex, isExpanded);
        setState(() {
          widget.items[panelIndex].isExpanded =
              !widget.items[panelIndex].isExpanded;
        });
      },
    );
  }
}
