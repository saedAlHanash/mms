import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/core/widgets/dashed_border.dart';

/// Membership pill: 12/600 text, height 22, horizontal padding 10.
class MembershipBadge extends StatelessWidget {
  const MembershipBadge({super.key, required this.type});

  final MembershipType type;

  @override
  Widget build(BuildContext context) {
    final colors = type.badge;

    final badge = Container(
      height: 22.0.h,
      padding: EdgeInsets.symmetric(horizontal: 10.0.w),
      alignment: .center,
      decoration: BoxDecoration(
        color: colors.bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: DrawableText(
        text: type.name,
        size: 12.0.sp,
        fontWeight: .w600,
        color: colors.fg,
        maxLines: 1,
      ),
    );

    final border = colors.border;
    if (border == null) return badge;
    return DashedBorder(color: border, radius: 999, child: badge);
  }
}
