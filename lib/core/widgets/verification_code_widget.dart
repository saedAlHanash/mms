import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:pinput/pinput.dart';

/// OTP input. Always LTR, 6 cells.
class PinCodeWidget extends StatelessWidget {
  const PinCodeWidget({
    super.key,
    this.onCompleted,
    this.onChange,
    this.validator,
  });

  final Function(String)? onCompleted;
  final Function(String)? onChange;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 24.0.sp,
      fontWeight: .w700,
      color: AppColorManager.neutral900,
    );

    final emptyTheme = PinTheme(
      width: 46.0.w,
      height: 56.0.h,
      textStyle: textStyle,
      decoration: BoxDecoration(
        color: AppColorManager.neutral25,
        borderRadius: BorderRadius.circular(10.0.r),
        border: Border.all(color: AppColorManager.neutral200),
      ),
    );

    final submittedTheme = emptyTheme.copyDecorationWith(color: AppColorManager.neutral0);

    final focusedTheme = emptyTheme.copyWith(
      textStyle: textStyle.copyWith(color: AppColorManager.primary500),
      decoration: BoxDecoration(
        color: AppColorManager.neutral0,
        borderRadius: BorderRadius.circular(10.0.r),
        border: Border.all(color: AppColorManager.primary500, width: 2),
        boxShadow: [BoxShadow(color: AppColorManager.primary100, spreadRadius: 4.0.r)],
      ),
    );

    final errorTheme = emptyTheme.copyDecorationWith(
      color: AppColorManager.neutral0,
      border: Border.all(color: AppColorManager.danger),
    );

    return Center(
      child: Directionality(
        textDirection: .ltr,
        child: Pinput(
          length: 6,
          onCompleted: onCompleted,
          onChanged: onChange,
          validator: validator,
          defaultPinTheme: emptyTheme,
          focusedPinTheme: focusedTheme,
          submittedPinTheme: submittedTheme,
          errorPinTheme: errorTheme,
          separatorBuilder: (_) => 8.0.horizontalSpace,
          errorTextStyle: TextStyle(fontSize: 13.0.sp, color: AppColorManager.dangerText),
          cursor: Container(width: 2, height: 24.0.h, color: AppColorManager.primary500),
        ),
      ),
    );
  }
}
