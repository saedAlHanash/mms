import 'package:mms/core/strings/app_color_manager.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/widgets/app_bar/app_bar_widget.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/core/widgets/my_text_form_widget.dart';

import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../bloc/login_cubit/login_cubit.dart';
import '../../bloc/login_social_cubit/login_social_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginCubit get loginCubit => context.read<LoginCubit>();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginCubit, LoginInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            Navigator.pushNamedAndRemoveUntil(
                context, RouteName.home, (route) => false);
          },
        ),
        BlocListener<LoginSocialCubit, LoginSocialInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            Navigator.pushNamedAndRemoveUntil(
                context, RouteName.home, (route) => false);
          },
        ),
      ],
      child: Scaffold(
        appBar: const AppBarWidget(zeroHeight: true),
        body: SingleChildScrollView(
          padding: MyStyle.authPagesPadding,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                10.0.verticalSpace,
                DrawableText(
                  text: S.of(context).login,
                  size: 40.0.spMin,
                  fontFamily: FontManager.cairoBold.name,
                  matchParent: true,
                ),
                10.0.verticalSpace,
                DrawableText(
                  text: S.of(context).signInToContinue,
                  size: 14.0.spMin,
                  matchParent: true,
                ),
                10.0.verticalSpace,
                ImageMultiType(
                  url: Assets.imagesLogo,
                  height: 200.0.r,
                  width: 200.0.r,
                ),
                30.0.verticalSpace,
                AutofillGroup(
                  child: Column(
                    children: [
                      MyTextFormOutLineWidget(
                        autofillHints: const [
                          AutofillHints.username,
                          AutofillHints.email,
                        ],
                        validator: (p0) => loginCubit.validateUserName,
                        label: S.of(context).userName,
                        initialValue: loginCubit.state.request.userName,
                        keyBordType: TextInputType.emailAddress,
                        icon: Assets.iconsCall,
                        onChanged: (val) => loginCubit.setUserName = val,
                      ),
                      15.0.verticalSpace,
                      MyTextFormOutLineWidget(
                        autofillHints: const [AutofillHints.password],
                        validator: (p0) => loginCubit.validatePassword,
                        label: S.of(context).password,
                        icon: Assets.iconsKey,
                        obscureText: true,
                        initialValue: loginCubit.state.request.password,
                        onChanged: (val) => loginCubit.setPassword = val,
                      ),
                    ],
                  ),
                ),
                // TextButton(
                //   onPressed: () {
                //     Navigator.pushNamed(
                //       context,
                //       RouteName.forgetPassword,
                //       arguments: loginCubit.state.request.phone,
                //     );
                //   },
                //   child: DrawableText(
                //     text: S.of(context).forgetPassword,
                //     matchParent: true,
                //     color: AppColorManager.mainColorLight,
                //   ),
                // ),
                20.0.verticalSpace,
                BlocBuilder<LoginCubit, LoginInitial>(
                  builder: (_, state) {
                    if (state.statuses.loading) {
                      return MyStyle.loadingWidget();
                    }
                    return MyButton(
                      text: S.of(context).login,
                      onTap: () {
                        if (!_formKey.currentState!.validate()) return;
                        TextInput.finishAutofillContext();
                        loginCubit.login();
                      },
                    );
                  },
                ),
                // 18.0.verticalSpace,
                // DrawableText(
                //   text: S.of(context).doNotHaveAnAccount,
                //   drawableEnd: TextButton(
                //     onPressed: () =>
                //         Navigator.pushNamed(context, RouteName.signup),
                //     child: DrawableText(
                //       fontFamily: FontManager.cairoBold.name,
                //       text: S.of(context).createNewAccount,
                //       color: AppColorManager.mainColorLight,
                //     ),
                //   ),
                // ),
                40.0.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ForgetAndRememberWidget extends StatefulWidget {
  const _ForgetAndRememberWidget();

  @override
  State<_ForgetAndRememberWidget> createState() =>
      _ForgetAndRememberWidgetState();
}

class _ForgetAndRememberWidgetState extends State<_ForgetAndRememberWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DrawableText(
          text: S.of(context).rememberMe,
          drawableEnd: Checkbox(
            value: true,
            onChanged: (value) {},
          ),
        ),
      ],
    );
  }
}
