import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/widgets/dashed_border.dart';

/// Empty state.
/// - [EmptyStateWidget.large]: centered circle + title + description (+ action).
/// - [EmptyStateWidget.inline]: dashed row inside a section.
class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget.large({
    super.key,
    required this.icon,
    required this.title,
    this.description,
    this.action,
  }) : _inline = false;

  const EmptyStateWidget.inline({
    super.key,
    required this.icon,
    required this.title,
    this.description,
  })  : action = null,
        _inline = true;

  /// Anything [ImageMultiType] accepts (IconData, asset path…).
  final dynamic icon;
  final String title;
  final String? description;
  final Widget? action;
  final bool _inline;

  @override
  Widget build(BuildContext context) => _inline ? _buildInline() : _buildLarge();

  Widget _circle(double size, double iconSize) => Container(
        width: size.r,
        height: size.r,
        alignment: .center,
        decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColorManager.primary50),
        child: ImageMultiType(
          url: icon,
          width: iconSize.r,
          height: iconSize.r,
          color: AppColorManager.primary500,
        ),
      );

  Widget _buildLarge() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.0.w, vertical: 24.0.h),
        child: Column(
          mainAxisSize: .min,
          children: [
            _circle(88, 36),
            16.0.verticalSpace,
            DrawableText(
              text: title,
              size: 18.0.sp,
              fontWeight: .w700,
              color: AppColorManager.neutral900,
              textAlign: .center,
            ),
            if ((description ?? '').isNotEmpty) ...[
              6.0.verticalSpace,
              DrawableText(
                text: description!,
                size: 14.0.sp,
                color: AppColorManager.neutral500,
                textAlign: .center,
              ),
            ],
            if (action != null) ...[16.0.verticalSpace, action!],
          ],
        ),
      ),
    );
  }

  Widget _buildInline() {
    return DashedBorder(
      color: AppColorManager.neutral200,
      radius: 12.0.r,
      child: Padding(
        padding: EdgeInsets.all(14.0.r),
        child: Row(
          children: [
            _circle(44, 22),
            12.0.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                mainAxisSize: .min,
                children: [
                  DrawableText(
                    text: title,
                    size: 15.0.sp,
                    fontWeight: .w700,
                    color: AppColorManager.neutral900,
                  ),
                  if ((description ?? '').isNotEmpty)
                    DrawableText(
                      text: description!,
                      size: 13.0.sp,
                      color: AppColorManager.neutral500,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
