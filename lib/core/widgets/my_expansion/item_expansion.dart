import 'package:flutter/material.dart';
import 'package:mms/core/strings/app_color_manager.dart';

class ItemExpansion {
  ItemExpansion({
    this.headerText,
    this.header,
    this.withSideColor = false,
    required this.body,
    this.isExpanded = false,
    this.enable = true,
    this.additional ,
  });

  final Widget? header;
  final String? headerText;
  final Widget body;
  bool isExpanded;
  bool enable;
  bool withSideColor;
  String? additional;
}

class ItemExpansionOption {
  ItemExpansionOption({
    this.withSideColor = false,
    this.color = AppColorManager.whit,
  });

  bool withSideColor;
  Color color;
}
