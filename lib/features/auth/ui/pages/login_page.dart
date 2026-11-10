import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/widgets/app_bar/app_bar_widget.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/core/widgets/my_text_form_widget.dart';
import 'package:mms/features/auth/bloc/login_cubit/login_cubit.dart';
import 'package:mms/features/auth/bloc/login_social_cubit/login_social_cubit.dart';
import 'package:mms/features/auth/ui/widget/auth_layout.dart';
import 'package:mms/generated/assets.dart';
import 'package:mms/generated/l10n.dart';
import 'package:mms/router/app_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginCubit get loginCubit => context.read<LoginCubit>();

  final _formKey = GlobalKey<FormState>();

  void _onLogin() {
    if (!_formKey.currentState!.validate()) return;
    TextInput.finishAutofillContext();
    loginCubit.login();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginCubit, LoginInitial>(
          listenWhen: (p, c) => c.done,
          listener: (context, state) {
            Navigator.pushNamedAndRemoveUntil(context, RouteName.home, (route) => false);
          },
        ),
        BlocListener<LoginSocialCubit, LoginSocialInitial>(
          listenWhen: (p, c) => c.done,
          listener: (context, state) {
            Navigator.pushNamedAndRemoveUntil(context, RouteName.home, (route) => false);
          },
        ),
      ],
      child: Scaffold(
        appBar: const AppBarWidget(zeroHeight: true),
        body: Form(
          key: _formKey,
          child: AuthPageLayout(
            topPadding: 88,
            content: [
              Center(
                child: ImageMultiType(
                  url: Assets.iconsFullLogoWithoutSlogen,
                  width: .5.sw,
                ),
              ),
              48.0.verticalSpace,
              AuthHeader(
                title: S.of(context).login,
                subtitle: S.of(context).loginSubtitle,
              ),
              28.0.verticalSpace,
              AutofillGroup(
                child: Column(
                  crossAxisAlignment: .stretch,
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
                      icon: Icons.person_2_outlined,
                      onChanged: (val) => loginCubit.setUserName = val,
                    ),
                    16.0.verticalSpace,
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
            ],
            bottom: [
              BlocBuilder<LoginCubit, LoginInitial>(
                builder: (_, state) {
                  return MyButton(
                    text: S.of(context).login,
                    loading: state.statuses.loading,
                    onTap: _onLogin,
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
              //      fontWeight: FontWeight.bold,
              //       text: S.of(context).createNewAccount,
              //       color: AppColorManager.mainColorLight,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ForgetAndRememberWidget extends StatefulWidget {
  const _ForgetAndRememberWidget();

  @override
  State<_ForgetAndRememberWidget> createState() => _ForgetAndRememberWidgetState();
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
