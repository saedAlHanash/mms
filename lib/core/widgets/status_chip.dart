import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/core/widgets/dashed_border.dart';
import 'package:mms/generated/l10n.dart';

/// Status pill: 7px dot + 13/600 label, height 24, horizontal padding 10.
class StatusChip extends StatelessWidget {
  const StatusChip({
    super.key,
    required this.colors,
    required this.label,
    this.glow = false,
  });

  StatusChip.meeting(MeetingStatus status, {Key? key})
      : this(key: key, colors: status.colors, label: status.realName, glow: status == .running);

  StatusChip.poll(PollStatus status, {Key? key})
      : this(
          key: key,
          colors: status.colors,
          label: switch (status) {
            .pending => S().statusPending,
            .open => S().statusOpen,
            .closed => S().statusClosed,
          },
          glow: status == .open,
        );

  StatusChip.discussion(DiscussionStatus status, {Key? key})
      : this(
          key: key,
          colors: status.colors,
          label: switch (status) {
            .pending => S().statusPending,
            .open => S().statusOpen,
            .closed => S().statusClosed,
          },
          glow: status == .open,
        );

  final StatusColors colors;
  final String label;

  /// Adds a 3px, 25% halo around the dot (used for the "running/open" state).
  final bool glow;

  @override
  Widget build(BuildContext context) {
    final chip = Container(
      height: 24.0.h,
      padding: EdgeInsets.symmetric(horizontal: 10.0.w),
      decoration: BoxDecoration(
        color: colors.bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: DrawableText(
        text: label,
        size: 13.0.sp,
        fontWeight: .w600,
        color: colors.fg,
        maxLines: 1,
        drawablePadding: 6.0.w,
        drawableStart: Container(
          width: 7.0.r,
          height: 7.0.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colors.dot,
            boxShadow: [
              if (glow) BoxShadow(color: colors.dot.withValues(alpha: 0.25), spreadRadius: 3.0.r),
            ],
          ),
        ),
      ),
    );

    final border = colors.border;
    if (border == null) return chip;
    return DashedBorder(color: border, radius: 999, child: chip);
  }
}
