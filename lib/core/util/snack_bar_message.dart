import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import 'package:mms/generated/l10n.dart';
import 'package:mms/core/app/app_widget.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/core/widgets/snake_bar_widget.dart';

class NoteMessage {
  static void showSuccessSnackBar({required String message, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(SnakeBarWidget.snackBar(text: message, isSuccess: true));
  }

  static void showErrorSnackBar({required String message, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(SnakeBarWidget.snackBar(text: message));
  }

  static void showSnakeBar({
    required String? message,
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnakeBarWidget.snackBar(text: message ?? ''));
  }

  static void showBottomSheet(BuildContext context, Widget child) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      builder: (builder) => child,
    );
  }

  static Future<bool> showBottomSheet1({required Widget child}) async {
    final result = await showModalBottomSheet(
      isScrollControlled: true,
      context: ctx!,
      backgroundColor: Colors.transparent,
      // barrierColor: Colors.transparent,
      builder: (context) => child,
    );

    return result ?? false;
  }

  static Future<bool> showConfirm(BuildContext context, {required String text}) async {
    // show the dialog
    final result = await showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.3),
      builder: (BuildContext context) {
        return Dialog(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0.r),
            ),
          ),
          elevation: 10.0,
          clipBehavior: Clip.hardEdge,
          child: Padding(
            padding: const EdgeInsets.all(15.0).r,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DrawableText(
                  text: text,
                  size: 22.0.spMin,
                  fontWeight: FontWeight.bold,
                  color: AppColorManager.mainColorDark,
                ),
                40.0.verticalSpace,
                MyButton(
                  text: S.of(context).confirm,
                  onTap: () => Navigator.pop(context, true),
                ),
                10.0.verticalSpace,
                MyButton(
                  text: S.of(context).cancel,
                  onTap: () => Navigator.pop(context, false),
                  color: AppColorManager.black,
                ),
                20.0.verticalSpace,
              ],
            ),
          ),
        );
      },
    );
    return (result ?? false);
  }

  static Future<bool> showErrorDialog(BuildContext context, {required String text, bool tryAgne = false}) async {
    // show the dialog
    final result = await showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.3),
      builder: (BuildContext context) {
        return Dialog(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0.r)),
          ),
          elevation: 10.0,
          clipBehavior: Clip.hardEdge,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DrawableText(
                  text: 'Oops!',
                  size: 20.0.spMin,
                  padding: const EdgeInsets.symmetric(vertical: 15.0).h,
                  fontWeight: FontWeight.bold,
                  color: AppColorManager.textColor,
                ),
                const Divider(color: Colors.black),
                DrawableText(
                  text: text,
                  textAlign: TextAlign.center,
                  size: 16.0.spMin,
                  padding: const EdgeInsets.symmetric(vertical: 20.0).h,
                  fontWeight: FontWeight.bold,
                  color: AppColorManager.textColor,
                ),
                const Divider(color: Colors.black),
                TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: DrawableText(text: tryAgne ? 'Try Again' : 'OK'))
              ],
            ),
          ),
        );
      },
    );

    return (result ?? false);
  }

  static void showDialogError(
    BuildContext context, {
    required String text,
  }) {
    // show the dialog
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.3),
      builder: (BuildContext context) {
        return Dialog(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0.r)),
          ),
          elevation: 10.0,
          clipBehavior: Clip.hardEdge,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DrawableText(
                text: 'Oops!',
                size: 20.0.spMin,
                padding: const EdgeInsets.symmetric(vertical: 15.0).h,
                fontWeight: FontWeight.bold,
                color: AppColorManager.textColor,
              ),
              const Divider(color: Colors.black),
              DrawableText(
                text: text,
                textAlign: TextAlign.center,
                size: 16.0.spMin,
                padding: const EdgeInsets.symmetric(vertical: 20.0).h,
                fontWeight: FontWeight.bold,
                color: AppColorManager.textColor,
              ),
              const Divider(color: Colors.black),
              TextButton(onPressed: () => Navigator.pop(context, true), child: const DrawableText(text: 'OK'))
            ],
          ),
        );
      },
    );
  }

  static void showMyDialog(BuildContext context, {required Widget child, Function(dynamic v)? onCancel}) {
    // show the dialog
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.3),
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          child: Dialog(
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16.0.r),
              ),
            ),
            insetPadding: const EdgeInsets.all(20.0).r,
            elevation: 10.0,
            clipBehavior: Clip.hardEdge,
            child: SingleChildScrollView(
              child: child,
            ),
          ),
        );
      },
    ).then((value) => onCancel?.call(value));
  }

  /// Error dialog (name kept for existing callers; no longer uses AwesomeDialog).
  /// A "no internet" message (482) gets the neutral icon.
  static Future<void> showAwesomeError({
    required BuildContext context,
    required String message,
  }) async {
    final noInternet = message.contains(S.of(context).noInternet);
    await _showStatusDialog(
      context,
      icon: noInternet ? Icons.wifi_off_rounded : Icons.error_outline_rounded,
      circleColor: noInternet ? AppColorManager.neutral50 : AppColorManager.dangerSoft,
      iconColor: noInternet ? AppColorManager.neutral700 : AppColorManager.danger,
      title: S.of(context).oops,
      message: message,
      buttonText: S.of(context).ok,
    );
  }

  /// Success dialog (name kept for existing callers; no longer uses AwesomeDialog).
  static Future<void> showAwesomeDoneDialog(BuildContext context, {required String message, Function()? onCancel}) async {
    await _showStatusDialog(
      context,
      icon: Icons.check_rounded,
      circleColor: AppColorManager.successSoft,
      iconColor: AppColorManager.success,
      title: S.of(context).done,
      message: message,
      buttonText: S.of(context).ok,
    );
    onCancel?.call();
  }

  /// Centered dialog: 56 circle + title 18/700 + message 15/24 + full-width button.
  static Future<void> _showStatusDialog(
    BuildContext context, {
    required IconData icon,
    required Color circleColor,
    required Color iconColor,
    required String title,
    required String message,
    required String buttonText,
  }) {
    return showDialog(
      context: context,
      barrierColor: AppColorManager.neutral900.withValues(alpha: 0.4),
      builder: (context) {
        return Dialog(
          backgroundColor: AppColorManager.neutral0,
          surfaceTintColor: AppColorManager.neutral0,
          insetPadding: EdgeInsets.symmetric(horizontal: 24.0.w),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0.r)),
          child: Padding(
            padding: EdgeInsets.all(24.0.r),
            child: Column(
              mainAxisSize: .min,
              children: [
                Container(
                  width: 56.0.r,
                  height: 56.0.r,
                  alignment: .center,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: circleColor),
                  child: ImageMultiType(url: icon, width: 28.0.r, height: 28.0.r, color: iconColor),
                ),
                12.0.verticalSpace,
                DrawableText(
                  text: title,
                  size: 18.0.sp,
                  fontWeight: .w700,
                  color: AppColorManager.neutral900,
                  textAlign: .center,
                ),
                8.0.verticalSpace,
                DrawableText(
                  text: message,
                  size: 15.0.sp,
                  color: AppColorManager.neutral700,
                  textAlign: .center,
                ),
                24.0.verticalSpace,
                MyButton(
                  width: double.infinity,
                  size: .dialog,
                  text: buttonText,
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<bool> showImageDialog(
    BuildContext context, {
    required List<String> images,
    required int currentPage,
  }) async {
    // show the dialog
    final controller = CarouselSliderController();
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          surfaceTintColor: Colors.transparent,
          alignment: Alignment.center,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0.r),
            ),
          ),
          elevation: 0.0,
          clipBehavior: Clip.hardEdge,
          child: SizedBox(
            height: 1.0.sh,
            child: CarouselSlider(
              items: images.map(
                (e) {
                  return ImageMultiType(
                    url: e,
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                },
              ).toList(),
              options: CarouselOptions(
                initialPage: currentPage,
                enableInfiniteScroll: false,
                autoPlayInterval: const Duration(seconds: 10),
                viewportFraction: 1,
              ),
            ),
          ),
        );
      },
    );
    return (result ?? false);
  }

  /// Confirmation dialog: 48 circle + title + optional [description] +
  /// "Cancel" (outline) then the action. [destructive] = red action
  /// (only for logout / ending a call).
  static Future<void> showCheckDialog(
    BuildContext context, {
    required String text,
    required String textButton,
    required dynamic image,
    Function()? onConfirm,
    String? description,
    bool destructive = false,
  }) async {
    final result = await showDialog(
      context: context,
      barrierColor: AppColorManager.neutral900.withValues(alpha: 0.4),
      builder: (BuildContext context) {
        final Widget leading = image is Widget
            ? image
            : Container(
                width: 48.0.r,
                height: 48.0.r,
                alignment: .center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: destructive ? AppColorManager.dangerSoft : AppColorManager.primary50,
                ),
                child: ImageMultiType(
                  url: image,
                  height: 24.0.r,
                  width: 24.0.r,
                  color: destructive ? AppColorManager.danger : AppColorManager.primary500,
                ),
              );

        return Dialog(
          backgroundColor: AppColorManager.neutral0,
          surfaceTintColor: AppColorManager.neutral0,
          insetPadding: EdgeInsets.symmetric(horizontal: 24.0.w),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0.r)),
          child: Padding(
            padding: EdgeInsets.all(24.0.r),
            child: Column(
              mainAxisSize: .min,
              crossAxisAlignment: .start,
              children: [
                leading,
                14.0.verticalSpace,
                DrawableText(
                  text: text,
                  size: 18.0.sp,
                  fontWeight: .w700,
                  color: AppColorManager.neutral900,
                ),
                if ((description ?? '').isNotEmpty) ...[
                  6.0.verticalSpace,
                  DrawableText(
                    text: description!,
                    size: 15.0.sp,
                    color: AppColorManager.neutral700,
                  ),
                ],
                24.0.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      child: MyButton(
                        size: .dialog,
                        width: double.infinity,
                        variant: .outline,
                        text: S.of(context).cancel,
                        onTap: () => Navigator.pop(context, false),
                      ),
                    ),
                    8.0.horizontalSpace,
                    Expanded(
                      child: MyButton(
                        size: .dialog,
                        width: double.infinity,
                        variant: destructive ? .danger : .primary,
                        text: textButton,
                        onTap: () => Navigator.pop(context, true),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    if (result == true) {
      onConfirm?.call();
    }
  }

  static Future<void> showBlurDialog(
    BuildContext context, {
    required Widget child,
    Function()? onCancel,
  }) async {
    // show the dialog
    final result = await showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.3),
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          child: Dialog(
            surfaceTintColor: Colors.white,
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16.0.r),
              ),
            ),
            elevation: 10.0,
            clipBehavior: Clip.hardEdge,
            child: child,
          ),
        );
      },
    );

    if (result == true) {
      onCancel?.call();
    }
  }
}
