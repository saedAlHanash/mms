import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/util/my_style.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/generated/l10n.dart';
import 'package:mms/router/app_router.dart';

class DonePage extends StatelessWidget {
  const DonePage({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = MyStyle.authPagesPadding;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(padding.left, 0, padding.right, padding.bottom),
          child: Column(
            crossAxisAlignment: .stretch,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: .center,
                  children: [
                    Container(
                      width: 120.0.r,
                      height: 120.0.r,
                      alignment: .center,
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColorManager.successSoft),
                      child: Container(
                        width: 80.0.r,
                        height: 80.0.r,
                        alignment: .center,
                        decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColorManager.success),
                        child: ImageMultiType(
                          url: Icons.check_rounded,
                          width: 40.0.r,
                          height: 40.0.r,
                          color: AppColorManager.neutral0,
                        ),
                      ),
                    ),
                    24.0.verticalSpace,
                    DrawableText(
                      text: S.of(context).isSuccess,
                      size: 24.0.sp,
                      fontWeight: .w700,
                      color: AppColorManager.neutral900,
                      textAlign: .center,
                    ),
                  ],
                ),
              ),
              MyButton(
                text: S.of(context).login,
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context, RouteName.login, (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
