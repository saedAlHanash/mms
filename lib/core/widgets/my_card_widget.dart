import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/util/my_style.dart';

/// `normal`: white, 1px `neutral100` border, radius 12.
/// `soft`: `neutral25`, 1px `neutral50` border, radius 16.
enum CardTone { normal, soft }

class MyCardWidget extends StatelessWidget {
  const MyCardWidget({
    super.key,
    this.margin,
    this.padding,
    this.cardColor,
    required this.child,
    this.elevation = 0,
    this.radios,
    this.tone = .normal,
  });

  final EdgeInsets? margin;
  final EdgeInsets? padding;

  /// Overrides the background of [tone].
  final Color? cardColor;
  final Widget child;
  final double elevation;

  /// Overrides the corner radius of [tone].
  final double? radios;
  final CardTone tone;

  @override
  Widget build(BuildContext context) {
    final isSoft = tone == .soft;
    final color = cardColor ?? (isSoft ? AppColorManager.neutral25 : AppColorManager.neutral0);
    final borderColor = isSoft ? AppColorManager.neutral50 : AppColorManager.neutral100;
    final radius = radios ?? (isSoft ? 16.0.r : 12.0.r);

    return Card(
      margin: margin,
      color: color,
      surfaceTintColor: color,
      clipBehavior: Clip.hardEdge,
      elevation: elevation,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: borderColor),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Padding(padding: padding ?? MyStyle.cardPadding, child: child),
    );
  }
}
