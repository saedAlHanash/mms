import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/util/shared_preferences.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/core/widgets/my_text_form_widget.dart';

import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../bloc/reset_password_cubit/reset_password_cubit.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late final ResetPasswordCubit resetPassCubit;
  late final ResetPasswordInitial resetPassState;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    resetPassCubit = context.read<ResetPasswordCubit>();
    resetPassState = context.read<ResetPasswordCubit>().state;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordCubit, ResetPasswordInitial>(
      listenWhen: (p, c) => c.statuses == CubitStatuses.done,
      listener: (context, state) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          RouteName.donePage,
          (route) => false,
        );
      },
      child: Scaffold(
        appBar: AppBarWidget(titleText: S.of(context).reset_password),
        bottomNavigationBar: TextButton(
          onPressed: () {
            AppSharedPreference.removePhone();
            Navigator.pushNamed(context, RouteName.login);
          },
          child: DrawableText(
            size: 18.0.sp,
            underLine: true,
            fontFamily: FontManager.cairoBold.name,
            text: '${S.of(context).login}.',
          ),
        ),
        body: SingleChildScrollView(
          padding: MyStyle.authPagesPadding,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                115.0.verticalSpace,
                DrawableText(
                  text: S.of(context).enter_new_password_and_confirm,
                  matchParent: true,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0).w,
                ),
                35.0.verticalSpace,
                MyTextFormOutLineWidget(
                  obscureText: true,
                  validator: (p0) => resetPassCubit.validatePassword,
                  label: S.of(context).password,
                  initialValue: resetPassCubit.state.request.password,
                  keyBordType: TextInputType.emailAddress,
                  onChanged: (val) => resetPassCubit.setPassword = val,
                ),
                20.0.verticalSpace,
                MyTextFormOutLineWidget(
                  obscureText: true,
                  validator: (p0) => resetPassCubit.validateConfirmPassword,
                  label: S.of(context).confirmNewPassword,
                  initialValue: resetPassCubit.state.request.passwordConfirmation,
                  onChanged: (val) => resetPassCubit.setConfirmPassword = val,
                ),
                30.0.verticalSpace,
                BlocBuilder<ResetPasswordCubit, ResetPasswordInitial>(
                  builder: (_, state) {
                    if (state.statuses.loading) {
                      return MyStyle.loadingWidget();
                    }
                    return MyButton(
                      text: S.of(context).changePassword,
                      onTap: () {
                        if (!_formKey.currentState!.validate()) return;
                        resetPassCubit.resetPassword();
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
