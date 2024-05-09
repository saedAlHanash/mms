import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_move/router/app_router.dart';

import '../../../../core/strings/app_color_manager.dart';

class AskAuthWidget extends StatelessWidget {
  const AskAuthWidget({super.key,  this.login});

  final bool? login;

  @override
  Widget build(BuildContext context) {
    return DrawableText(
      text: login == null
          ? 'أتذكر كلمة المرور الخاصة بي'
          : login!
              ? 'إنشاء حساب جديد؟'
              : 'هل لديك حساب؟',
      matchParent: true,
      padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
      drawableAlin: DrawableAlin.between,
      drawableEnd: TextButton(
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            (login ?? false) ? RouteName.signup : RouteName.login,
            (route) => false,
          );
        },
        child: DrawableText(
          text: (login ?? false) ? 'قم بالتسجيل' : 'تسجيل الدخول',
          color: AppColorManager.mainColor,
          fontFamily: FontManager.cairoBold.name,
        ),
      ),
    );
  }
}
