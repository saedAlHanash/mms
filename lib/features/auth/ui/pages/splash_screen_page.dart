import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../core/app/app_provider.dart';
import '../../../../core/strings/enum_manager.dart';import 'package:m_cubit/abstraction.dart';
import '../../../../generated/assets.dart';
import '../../../../router/app_router.dart';

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
            Navigator.pushReplacementNamed(context, RouteName.login);
            break;
          case StartPage.home:
            Navigator.pushReplacementNamed(context, RouteName.home);
            break;
          case StartPage.signupOtp:
          case StartPage.passwordOtp:
            Navigator.pushReplacementNamed(context, RouteName.confirmCode);
            break;
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40.0).w,
        height: 1.0.sh,
        alignment: Alignment.center,
        child: const ImageMultiType(url: Assets.iconsFullLogo),
      ),
    );
  }
}
