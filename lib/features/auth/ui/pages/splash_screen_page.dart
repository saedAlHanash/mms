import 'package:go_router/go_router.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import 'package:mms/core/strings/app_color_manager.dart';

import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/generated/assets.dart';
import 'package:mms/router/go_router.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        switch (getStartPage) {
          case StartPage.login:
            context.goNamed(RouteName.login);
            break;
          case StartPage.home:
            context.goNamed(RouteName.home);
            break;
          case StartPage.signupOtp:
          case StartPage.passwordOtp:
            context.goNamed(RouteName.confirmCode);
            break;
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorManager.neutral0,
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40.0.w),
            height: 1.0.sh,
            alignment: Alignment.center,
            child: const ImageMultiType(url: Assets.iconsFullLogo),
          ),
          PositionedDirectional(
            start: 0,
            end: 0,
            bottom: 64.0.h,
            child: const _SplashDots(),
          ),
        ],
      ),
    );
  }
}

/// Decorative page indicator: a 20×6 pill then two 6×6 dots.
class _SplashDots extends StatelessWidget {
  const _SplashDots();

  Widget _dot(double width, Color color) => Container(
        width: width.w,
        height: 6.0.h,
        margin: EdgeInsets.symmetric(horizontal: 3.0.w),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(999)),
      );

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: Row(
        mainAxisAlignment: .center,
        children: [
          _dot(20, AppColorManager.primary500),
          _dot(6, AppColorManager.primary200),
          _dot(6, AppColorManager.primary200),
        ],
      ),
    );
  }
}
