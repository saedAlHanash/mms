import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/features/meeting_live/ui/widgets/live_controls.dart';

/// ‹ 2026 › : previous / next year, never past the current one.
class YearSwitcher extends StatelessWidget {
  const YearSwitcher({super.key, required this.year, required this.onChange});

  final int year;
  final ValueChanged<int> onChange;

  @override
  Widget build(BuildContext context) {
    final isCurrent = year >= DateTime.now().year;
    return Row(
      mainAxisAlignment: .center,
      children: [
        LiveIconButton(
          icon: Icons.chevron_left_rounded,
          tooltip: '${year - 1}',
          onTap: () => onChange(year - 1),
        ),
        16.0.horizontalSpace,
        Directionality(
          textDirection: .ltr,
          child: DrawableText(text: '$year', size: 17.0.sp, fontWeight: .w700, color: AppColorManager.neutral900),
        ),
        16.0.horizontalSpace,
        LiveIconButton(
          icon: Icons.chevron_right_rounded,
          tooltip: '${year + 1}',
          onTap: isCurrent ? null : () => onChange(year + 1),
        ),
      ],
    );
  }
}
