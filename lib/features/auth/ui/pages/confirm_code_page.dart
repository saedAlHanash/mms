import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:m_cubit/abstraction.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/util/snack_bar_message.dart';
import 'package:mms/core/widgets/my_button.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../core/widgets/verification_code_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../bloc/confirm_code_cubit/confirm_code_cubit.dart';
import '../../bloc/resend_code_cubit/resend_code_cubit.dart';

class ConfirmCodePage extends StatefulWidget {
  const ConfirmCodePage({super.key});

  @override
  State<ConfirmCodePage> createState() => _ConfirmCodePageState();
}

class _ConfirmCodePageState extends State<ConfirmCodePage> {
  late final ConfirmCodeCubit confirmCodeCubit;
  late final ResendCodeCubit resendCodeCubit;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    confirmCodeCubit = context.read<ConfirmCodeCubit>();
    resendCodeCubit = context.read<ResendCodeCubit>();
    confirmCodeCubit.setPhone = AppSharedPreference.getPhone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ConfirmCodeCubit, ConfirmCodeInitial>(
          listenWhen: (p, current) => current.statuses == CubitStatuses.done,
          listener: (context, state) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RouteName.donePage,
              (route) => false,
            );
          },
        ),
        BlocListener<ResendCodeCubit, ResendCodeInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            NoteMessage.showAwesomeDoneDialog(context, message: '${S.of(context).done_resend_code} ${state.result}');
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBarWidget(titleText: S.of(context).confirmCode),
        body: Padding(
          padding: MyStyle.authPagesPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
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
              DrawableText(
                text: S.of(context).enterOTP,
                size: 24.0.sp,
                fontWeight: FontWeight.bold,
              ),
              DrawableText(
                text: '${S.of(context).doneSendSms} ${AppSharedPreference.getPhone}',
                size: 14.0.sp,
              ),
              Form(
                key: _formKey,
                child: PinCodeWidget(
                  onChange: (p0) => confirmCodeCubit.setCode = p0,
                  validator: (p0) => confirmCodeCubit.validateCode,
                ),
              ),
              BlocBuilder<ConfirmCodeCubit, ConfirmCodeInitial>(
                builder: (context, state) {
                  if (state.statuses.loading) {
                    return MyStyle.loadingWidget();
                  }
                  return MyButton(
                    text: S.of(context).verify,
                    onTap: () {
                      if (AppSharedPreference.getPhone.isEmpty) {
                        Navigator.pushReplacementNamed(context, RouteName.login);
                        return;
                      }
                      if (!_formKey.currentState!.validate()) return;
                      confirmCodeCubit.confirmCode();
                    },
                  );
                },
              ),
              BlocBuilder<ResendCodeCubit, ResendCodeInitial>(
                builder: (context, state) {
                  if (state.statuses.loading) {
                    return MyStyle.loadingWidget();
                  }
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColorManager.mainColor),
                      borderRadius: BorderRadius.circular(8.0.r),
                    ),
                    child: MyButton(
                      text: S.of(context).resend,
                      color: AppColorManager.whit,
                      textColor: AppColorManager.mainColor,
                      onTap: () {
                        if (AppSharedPreference.getPhone.isEmpty) {
                          Navigator.pushReplacementNamed(context, RouteName.login);
                          return;
                        }
                        resendCodeCubit.resendCode();
                      },
                    ),
                  );
                },
              ),
              TextButton(
                onPressed: () {
                  AppSharedPreference.removePhone().then((value) {
                    Navigator.pushNamed(context, RouteName.login);
                  });
                },
                child: DrawableText(
                  size: 18.0.sp,
                  fontWeight: FontWeight.bold,
                  text: '${S.of(context).alreadyHaveAnAccount}.',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
