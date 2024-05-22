import 'package:flutter/material.dart';

import '../strings/app_color_manager.dart';
import '../util/my_style.dart';

class MyCardWidget extends StatelessWidget {
  const MyCardWidget({
     super.key,
    this.margin,
    this.padding,
    this.cardColor = AppColorManager.f9,
    required this.child,
    this.elevation = 0,
    this.radios = 12.0,
  });

  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color cardColor;
  final Widget child;
  final double elevation;
  final double? radios;

  @override
  Widget build(BuildContext context) {
    var innerPadding = padding ?? MyStyle.cardPadding;

    //محتوى البطاقة
    final cardChild = Padding(padding: innerPadding, child: child);

    return Card(
      margin: margin,
      color: cardColor,
      surfaceTintColor: cardColor,
      clipBehavior: Clip.hardEdge,
      elevation: elevation,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radios ?? MyStyle.cardRadios),
      ),
      child: cardChild,
    );
  }
}
