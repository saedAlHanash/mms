import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/generated/assets.dart';
import 'package:mms/generated/l10n.dart';

/// Placeholder block for loading states (no shimmer package).
class SkeletonBox extends StatelessWidget {
  const SkeletonBox({super.key, this.width, this.height = 16, this.radius = 8});

  final double? width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height.h,
      decoration: BoxDecoration(
        color: AppColorManager.neutral50,
        borderRadius: BorderRadius.circular(radius.r),
      ),
    );
  }
}

/// Section title (`title` style) with an optional trailing text (13, `neutral500`).
class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, this.trailing});

  final String title;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    return DrawableText(
      text: title,
      size: 17.0.sp,
      fontWeight: .w600,
      color: AppColorManager.neutral900,
      matchParent: true,
      drawableEnd: trailing == null
          ? null
          : DrawableText(
              text: trailing!,
              size: 13.0.sp,
              color: AppColorManager.neutral500,
            ),
    );
  }
}

/// Red counter circle (`danger` / white 12/700). Shows `max+` above [max].
class CountBadge extends StatelessWidget {
  const CountBadge({super.key, required this.count, this.max = 9, this.size = 20});

  final int count;
  final int max;
  final double size;

  @override
  Widget build(BuildContext context) {
    if (count <= 0) return const SizedBox.shrink();
    return Container(
      constraints: BoxConstraints(minWidth: size.r, minHeight: size.r),
      padding: EdgeInsets.symmetric(horizontal: 5.0.w),
      alignment: .center,
      decoration: BoxDecoration(
        color: AppColorManager.danger,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColorManager.neutral0, width: 2),
      ),
      child: DrawableText(
        text: count > max ? '$max+' : '$count',
        size: 12.0.sp,
        fontWeight: .w700,
        color: AppColorManager.neutral0,
      ),
    );
  }
}

/// "My comment" bubble: `primary50`, radius 10, padding 8×12.
class CommentBubble extends StatelessWidget {
  const CommentBubble({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 8.0.h),
      decoration: BoxDecoration(
        color: AppColorManager.primary50,
        borderRadius: BorderRadius.circular(10.0.r),
      ),
      child: Column(
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          DrawableText(
            text: S.of(context).myComment,
            size: 12.0.sp,
            fontWeight: .w700,
            color: AppColorManager.primary700,
            drawablePadding: 6.0.w,
            drawableStart: ImageMultiType(
              url: Assets.iconsComment,
              width: 14.0.r,
              height: 14.0.r,
              color: AppColorManager.primary700,
            ),
          ),
          4.0.verticalSpace,
          DrawableText(
            text: text,
            size: 14.0.sp,
            color: AppColorManager.neutral900,
            matchParent: true,
          ),
        ],
      ),
    );
  }
}

/// Bottom sheet container: white, top radius 24, 40×4 handle.
class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({super.key, required this.child});

  final Widget child;

  /// Opens [child] in an [AppBottomSheet] that rises with the keyboard.
  static Future<T?> show<T>(BuildContext context, {required Widget child}) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AppBottomSheet(child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        decoration: BoxDecoration(
          color: AppColorManager.neutral0,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.0.r)),
        ),
        padding: EdgeInsets.fromLTRB(20.0.w, 10.0.h, 20.0.w, 24.0.h),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: .min,
            crossAxisAlignment: .stretch,
            children: [
              Center(
                child: Container(
                  width: 40.0.w,
                  height: 4.0.h,
                  decoration: BoxDecoration(
                    color: AppColorManager.neutral200,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              16.0.verticalSpace,
              child,
            ],
          ),
        ),
      ),
    );
  }
}
