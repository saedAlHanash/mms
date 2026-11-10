import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/strings/app_color_manager.dart';

enum IconTileTone { primary, neutral, danger }

/// Rounded square holding an icon (36 / 40 / 44).
class IconTile extends StatelessWidget {
  const IconTile({
    super.key,
    required this.icon,
    this.size = 40,
    this.iconSize,
    this.tone = .primary,
  });

  /// Anything [ImageMultiType] accepts (IconData, asset path…).
  final dynamic icon;
  final double size;
  final double? iconSize;
  final IconTileTone tone;

  @override
  Widget build(BuildContext context) {
    final (background, foreground) = switch (tone) {
      .primary => (AppColorManager.primary50, AppColorManager.primary500),
      .neutral => (AppColorManager.neutral50, AppColorManager.neutral500),
      .danger => (AppColorManager.dangerSoft, AppColorManager.danger),
    };

    final glyph = (iconSize ?? size / 2).r;

    return Container(
      width: size.r,
      height: size.r,
      alignment: .center,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular((size >= 44 ? 12.0 : 10.0).r),
      ),
      child: ImageMultiType(url: icon, width: glyph, height: glyph, color: foreground),
    );
  }
}
