import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../strings/app_color_manager.dart';

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
    this.enable,
    this.loading = false,
    this.padding,
    this.startIcon,
    this.endIcon,
  });

  final Widget? child;
  final String text;
  final Color? textColor;
  final Color? color;
  final double? elevation;
  final double? width;
  final bool? enable;
  final EdgeInsets? padding;
  final Function()? onTap;
  final bool loading;
  final Widget? startIcon;
  final Widget? endIcon;

  @override
  Widget build(BuildContext context) {
    final child = this.child ??
        DrawableText(
          text: text,
          color: textColor ?? AppColorManager.whit,
          fontFamily: FontManager.cairoBold.name,
          drawablePadding: 10.0.w,
          drawableEnd: loading
              ? SizedBox(
                  height: 15.0.r,
                  width: 15.0.r,
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: color,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : endIcon,
          drawableStart: startIcon,
          size: 18.0.sp,
        );

    return SizedBox(
      width: width ?? .9.sw,
      child: ElevatedButton(
        style: ButtonStyle(
          surfaceTintColor: MaterialStatePropertyAll(color),
          backgroundColor: MaterialStatePropertyAll(color),
          padding: const MaterialStatePropertyAll(EdgeInsets.zero),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0.r),
            ),
          ),
          alignment: Alignment.center,
        ),
        onPressed: loading
            ? null
            : !(enable ?? true)
                ? null
                : onTap,
        child: child,
      ),
    );
  }
}
