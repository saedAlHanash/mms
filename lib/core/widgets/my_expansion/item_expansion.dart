import 'package:flutter/material.dart';
import 'package:mms/core/strings/app_color_manager.dart';

class ItemExpansion {
  ItemExpansion({
    this.header,
    required this.body,
    this.isExpanded = false,
    this.enable = true,
    this.additional ,
  });

  final Widget? header;
  final Widget body;
  bool isExpanded;
  bool enable;

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
