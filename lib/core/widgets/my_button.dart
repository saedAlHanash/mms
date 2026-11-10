import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mms/core/strings/app_color_manager.dart';

/// Visual variants of [MyButton].
enum MyButtonVariant { primary, tonal, outline, text, danger, dangerSoft }

/// Heights of [MyButton]: large 52 · dialog 48 · medium 44 · small 40.
enum MyButtonSize {
  large(52),
  dialog(48),
  medium(44),
  small(40);

  const MyButtonSize(this.height);

  final double height;
}

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    this.child,
    this.onTap,
    this.text = '',
    this.color,
    this.elevation,
    this.textColor,
    this.width,
    this.enable = true,
    this.loading = false,
    this.padding,
    this.startIcon,
    this.endIcon,
    this.variant = .primary,
    this.size = .large,
  });

  final Widget? child;
  final String text;
  final Color? textColor;

  /// Overrides the background color of the [variant].
  final Color? color;
  final double? elevation;
  final double? width;
  final bool enable;
  final EdgeInsets? padding;
  final Function()? onTap;
  final bool loading;
  final Widget? startIcon;
  final Widget? endIcon;
  final MyButtonVariant variant;
  final MyButtonSize size;

  Color get _background => switch (variant) {
        .primary => AppColorManager.primary500,
        .tonal => AppColorManager.primary50,
        .outline => AppColorManager.neutral0,
        .text => Colors.transparent,
        .danger => AppColorManager.danger,
        .dangerSoft => AppColorManager.dangerSoft,
      };

  Color get _pressedBackground => switch (variant) {
        .primary => AppColorManager.primary600,
        .tonal => AppColorManager.primary100,
        .outline => AppColorManager.neutral25,
        .text => AppColorManager.primary50,
        .danger => AppColorManager.dangerText,
        .dangerSoft => AppColorManager.dangerSoft,
      };

  Color get _foreground => switch (variant) {
        .primary || .danger => AppColorManager.neutral0,
        .tonal => AppColorManager.primary700,
        .outline => AppColorManager.neutral900,
        .text => AppColorManager.primary600,
        .dangerSoft => AppColorManager.dangerText,
      };

  @override
  Widget build(BuildContext context) {
    final isDisabled = !enable;

    final background = isDisabled ? AppColorManager.neutral50 : (color ?? _background);
    final foreground = isDisabled ? AppColorManager.neutral500 : (textColor ?? _foreground);

    final BorderSide border;
    if (isDisabled) {
      border = const BorderSide(color: AppColorManager.neutral100);
    } else if (variant == .outline && color == null) {
      border = const BorderSide(color: AppColorManager.neutral200);
    } else {
      border = BorderSide.none;
    }

    final fontSize = size == .small ? 14.0 : 16.0;

    final content = loading
        ? SizedBox(
            height: 20.0.r,
            width: 20.0.r,
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              valueColor: AlwaysStoppedAnimation<Color>(foreground),
            ),
          )
        : child ??
            DrawableText(
              text: text,
              color: foreground,
              fontWeight: .w700,
              size: fontSize.sp,
              textAlign: .center,
              maxLines: 1,
              drawablePadding: 8.0.w,
              drawableStart: startIcon,
              drawableEnd: endIcon,
            );

    return SizedBox(
      width: width ?? .9.sw,
      height: size.height.h,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: WidgetStatePropertyAll(elevation ?? 0),
          shadowColor: const WidgetStatePropertyAll(Colors.transparent),
          surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
          minimumSize: WidgetStatePropertyAll(Size(0, size.height.h)),
          padding: WidgetStatePropertyAll(padding ?? EdgeInsets.symmetric(horizontal: 16.0.w)),
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (states) {
              if (!isDisabled && !loading && color == null && states.contains(WidgetState.pressed)) {
                return _pressedBackground;
              }
              return background;
            },
          ),
          foregroundColor: WidgetStatePropertyAll(foreground),
          overlayColor: WidgetStatePropertyAll(foreground.withValues(alpha: 0.08)),
          side: WidgetStatePropertyAll(border),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0.r)),
          ),
          alignment: .center,
        ),
        onPressed: (loading || isDisabled) ? null : onTap,
        child: content,
      ),
    );
  }
}
