import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/util/shared_preferences.dart';
import 'package:mms/core/util/snack_bar_message.dart';
import 'package:mms/core/widgets/app_bar/app_bar_widget.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/core/widgets/verification_code_widget.dart';
import 'package:mms/features/auth/bloc/confirm_code_cubit/confirm_code_cubit.dart';
import 'package:mms/features/auth/bloc/resend_code_cubit/resend_code_cubit.dart';
import 'package:mms/features/auth/ui/widget/auth_layout.dart';
import 'package:mms/generated/l10n.dart';
import 'package:mms/router/app_router.dart';

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
          listenWhen: (p, c) => c.done,
          listener: (context, state) {
            NoteMessage.showAwesomeDoneDialog(context, message: '${S.of(context).done_resend_code} ${state.result}');
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBarWidget(titleText: S.of(context).confirmCode),
        body: AuthPageLayout(
          topPadding: 16,
          content: [
            AuthInfoBox(text: S.of(context).doneSendCode, success: true),
            32.0.verticalSpace,
            AuthHeader(
              title: S.of(context).enterOTP,
              subtitleWidget: DrawableText(
                text: S.of(context).doneSendSms,
                size: 15.0.sp,
                color: AppColorManager.neutral700,
                matchParent: true,
                drawablePadding: 4.0.w,
                drawableEnd: Directionality(
                  textDirection: .ltr,
                  child: DrawableText(
                    text: AppSharedPreference.getPhone,
                    size: 15.0.sp,
                    fontWeight: .w700,
                    color: AppColorManager.neutral900,
                  ),
                ),
              ),
            ),
            32.0.verticalSpace,
            Form(
              key: _formKey,
              child: PinCodeWidget(
                onChange: (p0) => confirmCodeCubit.setCode = p0,
                validator: (p0) => confirmCodeCubit.validateCode,
              ),
            ),
          ],
          bottom: [
            BlocBuilder<ConfirmCodeCubit, ConfirmCodeInitial>(
              builder: (context, state) {
                return MyButton(
                  text: S.of(context).verify,
                  loading: state.statuses.loading,
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
            12.0.verticalSpace,
            BlocBuilder<ResendCodeCubit, ResendCodeInitial>(
              builder: (context, state) {
                return MyButton(
                  text: S.of(context).resendCode,
                  variant: .outline,
                  loading: state.statuses.loading,
                  onTap: () {
                    if (AppSharedPreference.getPhone.isEmpty) {
                      Navigator.pushReplacementNamed(context, RouteName.login);
                      return;
                    }
                    resendCodeCubit.resendCode();
                  },
                );
              },
            ),
            16.0.verticalSpace,
            AuthLink(
              leading: S.of(context).alreadyHaveAnAccount,
              text: S.of(context).login,
              onTap: () {
                AppSharedPreference.removePhone().then((value) {
                  if (context.mounted) Navigator.pushNamed(context, RouteName.login);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
