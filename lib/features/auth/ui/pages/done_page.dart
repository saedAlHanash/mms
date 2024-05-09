import 'package:e_move/core/widgets/my_button.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';

class DonePage extends StatelessWidget {
  const DonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          200.0.verticalSpace,
          ImageMultiType(
            url: Assets.iconsDone,
            height: 90.0.r,
            width: 90.0.r,
          ),
          20.0.verticalSpace,
          DrawableText(
            text: S.of(context).isSuccess,
            size: 24.0.sp,
            fontFamily: FontManager.cairoBold.name,
            textAlign: TextAlign.center,
          ),
          200.0.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 70.0).r,
            child: MyButton(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, RouteName.login, (route) => false);
              },
              text: S.of(context).done,
            ),
          ),
        ],
      ),
    );
  }
}

