import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/strings/app_color_manager.dart';

/// Snackbar content: 24 circle (`success` / `danger`) + white 15 text.
class SnakeBarWidget extends StatelessWidget {
  const SnakeBarWidget({super.key, required this.text, this.isSuccess = false});

  final String text;
  final bool isSuccess;

  /// Floating dark snackbar (`neutral900`, radius 12) holding a [SnakeBarWidget].
  static SnackBar snackBar({required String text, bool isSuccess = false}) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      backgroundColor: AppColorManager.neutral900,
      margin: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.0.h),
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 14.0.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0.r)),
      content: SnakeBarWidget(text: text, isSuccess: isSuccess),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DrawableText(
      text: text,
      size: 15.0.sp,
      color: AppColorManager.neutral0,
      matchParent: true,
      drawablePadding: 12.0.w,
      drawableStart: Container(
        width: 24.0.r,
        height: 24.0.r,
        alignment: .center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSuccess ? AppColorManager.success : AppColorManager.danger,
        ),
        child: ImageMultiType(
          url: isSuccess ? Icons.check_rounded : Icons.priority_high_rounded,
          width: 14.0.r,
          height: 14.0.r,
          color: AppColorManager.neutral0,
        ),
      ),
    );
  }
}
