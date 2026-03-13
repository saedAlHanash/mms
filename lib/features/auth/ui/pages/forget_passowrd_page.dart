import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/widgets/app_bar/app_bar_widget.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/core/widgets/my_text_form_widget.dart';
import 'package:mms/generated/assets.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../bloc/forget_password_cubit/forget_password_cubit.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key, this.phone});

  final String? phone;

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  late final ForgetPasswordCubit forgetPasswordCubit;
  late final ForgetPasswordInitial forgetPasswordState;

  @override
  void initState() {
    forgetPasswordCubit = context.read<ForgetPasswordCubit>();
    forgetPasswordState = context.read<ForgetPasswordCubit>().state;

    if (widget.phone != null) {
      forgetPasswordState.phoneC.text = widget.phone!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgetPasswordCubit, ForgetPasswordInitial>(
      listenWhen: (p, c) => c.done,
      listener: (context, state) {
        Navigator.pushNamedAndRemoveUntil(context, RouteName.otpPassword, (route) => false);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBarWidget(titleText: S.of(context).forgetPassword),
        body: Padding(
          padding: MyStyle.pagePadding,
          child: Column(
            children: [
              ImageMultiType(
                url: Assets.iconsKey,
                height: 150.0.r,
                width: 150.0.r,
              ),
              50.0.verticalSpace,
              Container(
                width: 1.0.sw,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0.r),
                    color: AppColorManager.f1,
                    border: Border.all(color: AppColorManager.mainColorLight)),
                padding: const EdgeInsets.all(12.0).r,
                child: DrawableText(
                  text: S.of(context).doneSendCode,
                  size: 14.0.sp,
                ),
              ),
              30.0.verticalSpace,
              MyTextFormOutLineWidget(
                iconWidget: Padding(
                  padding: const EdgeInsets.all(15.0).r,
                  child: const ImageMultiType(
                    url: Assets.iconsPhone,
                  ),
                ),
                keyBordType: TextInputType.phone,
                controller: forgetPasswordState.phoneC,
                label: S.of(context).phoneNumber,
              ),
              const Spacer(),
              BlocBuilder<ForgetPasswordCubit, ForgetPasswordInitial>(
                builder: (_, state) {
                  if (state.loading) {
                    return MyStyle.loadingWidget();
                  }
                  return MyButton(
                    text: S.of(context).continueTo,
                    onTap: () {
                      forgetPasswordCubit.forgetPassword();
                    },
                  );
                },
              ),
              20.0.verticalSpace,
              DrawableText(
                text: S.of(context).rememberPassword,
                drawableEnd: TextButton(
                  onPressed: () => Navigator.pushReplacementNamed(context, RouteName.login),
                  child: DrawableText(
                    fontWeight: FontWeight.bold,
                    text: S.of(context).login,
                    color: AppColorManager.mainColorLight,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
