import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/util/my_style.dart';

/// Auth layout: [content] scrolls at the top, [bottom] (main button + link)
/// stays pinned at the bottom, above the keyboard. No overflow on small screens.
class AuthPageLayout extends StatelessWidget {
  const AuthPageLayout({
    super.key,
    required this.content,
    this.bottom = const [],
    this.topPadding = 24,
  });

  final List<Widget> content;
  final List<Widget> bottom;
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    final padding = MyStyle.authPagesPadding;

    return SafeArea(
      top: false,
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(padding.left, topPadding.h, padding.right, 24.0.h),
              child: Column(crossAxisAlignment: .stretch, children: content),
            ),
          ),
          if (bottom.isNotEmpty)
            Padding(
              padding: EdgeInsets.fromLTRB(padding.left, 0, padding.right, padding.bottom),
              child: Column(mainAxisSize: .min, crossAxisAlignment: .stretch, children: bottom),
            ),
        ],
      ),
    );
  }
}

/// 72 icon circle (optional) + `headlineLg` title + 15/24 description.
class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
    this.icon,
    required this.title,
    this.subtitle,
    this.subtitleWidget,
  });

  /// Anything [ImageMultiType] accepts (IconData, asset path…).
  final dynamic icon;
  final String title;
  final String? subtitle;
  final Widget? subtitleWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      mainAxisSize: .min,
      children: [
        if (icon != null) ...[
          Container(
            width: 72.0.r,
            height: 72.0.r,
            alignment: .center,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColorManager.primary50),
            child: ImageMultiType(
              url: icon,
              width: 32.0.r,
              height: 32.0.r,
              color: AppColorManager.primary500,
            ),
          ),
          20.0.verticalSpace,
        ],
        DrawableText(
          text: title,
          size: 24.0.sp,
          fontWeight: .w700,
          color: AppColorManager.neutral900,
          matchParent: true,
        ),
        if (subtitleWidget != null || (subtitle ?? '').isNotEmpty) ...[
          4.0.verticalSpace,
          subtitleWidget ??
              DrawableText(
                text: subtitle!,
                size: 15.0.sp,
                color: AppColorManager.neutral700,
                matchParent: true,
              ),
        ],
      ],
    );
  }
}

/// Centered text link (14/700 `primary600`) with a 44px touch height.
/// [leading] is an optional plain text shown before the link.
class AuthLink extends StatelessWidget {
  const AuthLink({super.key, required this.text, required this.onTap, this.leading});

  final String text;
  final VoidCallback onTap;
  final String? leading;

  @override
  Widget build(BuildContext context) {
    final link = TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        minimumSize: Size(44.0.w, 44.0.h),
        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
        foregroundColor: AppColorManager.primary600,
      ),
      child: DrawableText(
        text: text,
        size: 14.0.sp,
        fontWeight: .w700,
        color: AppColorManager.primary600,
      ),
    );

    if (leading == null) return Center(child: link);

    return Center(
      child: DrawableText(
        text: leading!,
        size: 14.0.sp,
        color: AppColorManager.neutral700,
        drawableEnd: link,
      ),
    );
  }
}

/// Soft info strip: `primary50` (info) or `successSoft` (success), radius 12.
class AuthInfoBox extends StatelessWidget {
  const AuthInfoBox({super.key, required this.text, this.success = false});

  final String text;
  final bool success;

  @override
  Widget build(BuildContext context) {
    final Widget leading = success
        ? Container(
            width: 24.0.r,
            height: 24.0.r,
            alignment: .center,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColorManager.success),
            child: ImageMultiType(
              url: Icons.check_rounded,
              width: 14.0.r,
              height: 14.0.r,
              color: AppColorManager.neutral0,
            ),
          )
        : ImageMultiType(
            url: Icons.chat_bubble_outline_rounded,
            width: 20.0.r,
            height: 20.0.r,
            color: AppColorManager.primary500,
          );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.0.w, vertical: 12.0.h),
      decoration: BoxDecoration(
        color: success ? AppColorManager.successSoft : AppColorManager.primary50,
        borderRadius: BorderRadius.circular(12.0.r),
      ),
      child: DrawableText(
        text: text,
        size: 14.0.sp,
        fontWeight: success ? .w600 : .w400,
        color: success ? AppColorManager.successText : AppColorManager.primary800,
        matchParent: true,
        drawablePadding: 10.0.w,
        drawableStart: leading,
      ),
    );
  }
}
