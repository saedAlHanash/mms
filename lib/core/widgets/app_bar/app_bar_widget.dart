import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/app/bloc/loading_cubit.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/util/my_style.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
    this.titleText,
    this.elevation,
    this.zeroHeight,
    this.actions,
    this.backBtn,
    this.title,
  });

  final String? titleText;
  final Widget? title;
  final Widget? backBtn;
  final bool? zeroHeight;
  final double? elevation;
  final List<Widget>? actions;

  static double get _height => 64.0.h;

  bool get _isZero => zeroHeight ?? false;

  @override
  Widget build(BuildContext context) {
    final leading = backBtn ?? (Navigator.canPop(context) ? const BackBtnWidget() : null);

    return WillPopScope(
      onWillPop: () async => context.read<LoadingCubit>().isLoadingForPop(),
      child: AppBar(
        backgroundColor: AppColorManager.neutral0,
        surfaceTintColor: AppColorManager.neutral0,
        toolbarHeight: _isZero ? 0 : _height,
        centerTitle: false,
        titleSpacing: leading == null ? 20.0.w : 4.0.w,
        leadingWidth: leading == null ? null : 56.0.w,
        title: title ??
            DrawableText(
              text: titleText ?? '',
              size: 18.0.sp,
              fontWeight: .w700,
              color: AppColorManager.neutral900,
              maxLines: 2,
              textAlign: .start,
            ),
        leading: leading,
        actions: actions,
        elevation: elevation ?? 0.0,
        scrolledUnderElevation: 0.0,
        shape: _isZero ? null : const Border(bottom: BorderSide(color: AppColorManager.neutral50)),
        shadowColor: AppColorManager.black.withValues(alpha: 0.28),
        iconTheme: const IconThemeData(color: AppColorManager.primary500),
      ),
    );
  }

  @override
  Size get preferredSize => Size(1.0.sw, _isZero ? 0 : _height);
}

/// Square action button for [AppBarWidget.actions]: 44×44, radius 10,
/// `primary50` background and `primary500` icon.
class AppBarActionButton extends StatelessWidget {
  const AppBarActionButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.tooltip,
  });

  /// Anything [ImageMultiType] accepts (IconData, asset path…).
  final dynamic icon;
  final VoidCallback onTap;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final button = Material(
      color: AppColorManager.primary50,
      borderRadius: BorderRadius.circular(10.0.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0.r),
        onTap: onTap,
        child: SizedBox(
          width: 44.0.r,
          height: 44.0.r,
          child: Center(
            child: ImageMultiType(
              url: icon,
              width: 22.0.r,
              height: 22.0.r,
              color: AppColorManager.primary500,
            ),
          ),
        ),
      ),
    );

    return Padding(
      padding: EdgeInsetsDirectional.only(end: 16.0.w),
      child: tooltip == null ? button : Tooltip(message: tooltip!, child: button),
    );
  }
}
