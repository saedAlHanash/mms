import 'dart:async';

import 'package:e_move/core/api_manager/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:e_move/core/util/shared_preferences.dart';

import '../../../../core/app/app_provider.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/my_style.dart';
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
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);

    Future.delayed(
      const Duration(seconds: 2),
      () {
        loggerObject.t(getStartPage.name);
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
  void dispose() {
    super.dispose();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values); // to re-show bars
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 1.0.sw,
        height: 1.0.sh,
        child: const Center(
          child: ImageMultiType(url: Assets.imagesLogo),
        ),
      ),
    );
  }
}
