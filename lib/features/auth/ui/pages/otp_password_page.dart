import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/util/snack_bar_message.dart';
import 'package:mms/core/widgets/my_button.dart';

import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../core/widgets/verification_code_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../bloc/otp_password_cubit/otp_password_cubit.dart';
import '../../bloc/resend_code_cubit/resend_code_cubit.dart';

class OtpPasswordPage extends StatefulWidget {
  const OtpPasswordPage({super.key});

  @override
  State<OtpPasswordPage> createState() => _OtpPasswordPageState();
}

class _OtpPasswordPageState extends State<OtpPasswordPage> {
  late final OtpPasswordCubit confirmCodeCubit;
  late final ResendCodeCubit resendCodeCubit;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    confirmCodeCubit = context.read<OtpPasswordCubit>();
    resendCodeCubit = context.read<ResendCodeCubit>();
    confirmCodeCubit.setPhone = AppProvider.getPhoneCached;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<OtpPasswordCubit, OtpPasswordInitial>(
          listenWhen: (p, current) => current.statuses == CubitStatuses.done,
          listener: (context, state) {
            Navigator.pushNamedAndRemoveUntil(
                context, RouteName.resetPasswordPage, (route) => false);
          },
        ),
        BlocListener<ResendCodeCubit, ResendCodeInitial>(
          listenWhen: (p, current) => current.statuses == CubitStatuses.done,
          listener: (context, state) {
            NoteMessage.showAwesomeDoneDialog(context,
                message: '${S.of(context).done_resend_code} ${state.result}');
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBarWidget(titleText: S.of(context).forgetPassword),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              DrawableText(text: S.of(context).enterOTP),
              35.0.verticalSpace,
              Form(
                key: _formKey,
                child: PinCodeWidget(
                  onChange: (p0) => confirmCodeCubit.setCode = p0,
                  validator: (p0) => confirmCodeCubit.validateCode,
                ),
              ),
              35.0.verticalSpace,
              DrawableText(
                text: S.of(context).didNotReceiveOTP,
                drawablePadding: 10.0.w,
                drawableEnd: TextButton(
                  onPressed: () => resendCodeCubit.resendCode(),
                  child: BlocBuilder<ResendCodeCubit, ResendCodeInitial>(
                    builder: (context, state) {
                      if (state.statuses == CubitStatuses.loading) {
                        return MyStyle.loadingWidget();
                      }
                      return DrawableText(
                        text: S.of(context).resend,
                        underLine: true,
                        fontFamily: FontManager.cairoBold.name,
                      );
                    },
                  ),
                ),
              ),
              90.0.verticalSpace,
              BlocBuilder<OtpPasswordCubit, OtpPasswordInitial>(
                builder: (context, state) {
                  if (state.statuses.loading) {
                    return MyStyle.loadingWidget();
                  }
                  return MyButton(
                    text: S.of(context).verify,
                    onTap: () {
                      if (AppProvider.getPhoneCached.isEmpty) {
                        Navigator.pushReplacementNamed(context, RouteName.login);
                        return;
                      }

                      if (!_formKey.currentState!.validate()) return;
                      confirmCodeCubit.confirmCode();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
