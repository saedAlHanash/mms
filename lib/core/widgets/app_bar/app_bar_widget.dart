import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mms/core/util/my_style.dart';

import '../../app/bloc/loading_cubit.dart';
import '../../strings/app_color_manager.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
     super.key,
    this.titleText,
    this.elevation,
    this.zeroHeight,
    this.actions,
    this.title,
  });

  final String? titleText;
  final Widget? title;

  final bool? zeroHeight;
  final double? elevation;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => context.read<LoadingCubit>().isLoadingForPop(),
      child: AppBar(
        backgroundColor: AppColorManager.whit,
        surfaceTintColor: Colors.white,
        toolbarHeight: (zeroHeight ?? false) ? 0 : 80.0.h,
        title: title ??
            DrawableText(
              textAlign: TextAlign.center,
              text: titleText ?? '',
              size: 28.0.spMin,
              fontWeight: FontWeight.bold,
              fontFamily: FontManager.cairoBold.name,
            ),
        leading: Navigator.canPop(context) ? const BackBtnWidget() : null,
        actions: actions,
        elevation: elevation ?? 0.0,
        shadowColor: AppColorManager.black.withOpacity(0.28),
        iconTheme: const IconThemeData(color: AppColorManager.mainColor),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(1.0.sw, (zeroHeight ?? false) ? 0 : 80.0.h);
}
