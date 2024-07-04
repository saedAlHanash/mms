import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';

import 'item_expansion.dart';
import 'my_expansion_panal.dart';

class MyExpansionWidget extends StatefulWidget {
  const MyExpansionWidget({
    super.key,
    required this.items,
    this.onTapItem,
    this.decoration,
    this.margin,
  });

  final List<ItemExpansion> items;
  final BoxDecoration? decoration;
  final EdgeInsets? margin;
  final Function(int)? onTapItem;

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
          headerBuilder: (_, __) {
            return e.header ?? const DrawableText(text: 'header');
          },
          margin: widget.margin,
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
        setState(() {
          widget.items[panelIndex].isExpanded =
              !widget.items[panelIndex].isExpanded;
        });
      },
    );
  }
}
