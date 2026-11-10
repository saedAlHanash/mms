import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/util/my_style.dart';
import 'package:mms/core/util/shared_preferences.dart';
import 'package:mms/core/util/snack_bar_message.dart';
import 'package:mms/core/widgets/app_bar/app_bar_widget.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/core/widgets/verification_code_widget.dart';
import 'package:mms/features/auth/bloc/otp_password_cubit/otp_password_cubit.dart';
import 'package:mms/features/auth/bloc/resend_code_cubit/resend_code_cubit.dart';
import 'package:mms/features/auth/ui/widget/auth_layout.dart';
import 'package:mms/generated/l10n.dart';
import 'package:mms/router/app_router.dart';

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
            Navigator.pushNamedAndRemoveUntil(context, RouteName.resetPasswordPage, (route) => false);
          },
        ),
        BlocListener<ResendCodeCubit, ResendCodeInitial>(
          listenWhen: (p, current) => current.statuses == CubitStatuses.done,
          listener: (context, state) {
            NoteMessage.showAwesomeDoneDialog(context, message: '${S.of(context).done_resend_code} ${state.result}');
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBarWidget(titleText: S.of(context).forgetPassword),
        body: AuthPageLayout(
          content: [
            AuthHeader(
              icon: Icons.sms_outlined,
              title: S.of(context).enterOTP,
            ),
            32.0.verticalSpace,
            Form(
              key: _formKey,
              child: PinCodeWidget(
                onChange: (p0) => confirmCodeCubit.setCode = p0,
                validator: (p0) => confirmCodeCubit.validateCode,
              ),
            ),
            24.0.verticalSpace,
            Center(
              child: DrawableText(
                text: S.of(context).didNotReceiveOTP,
                size: 14.0.sp,
                color: AppColorManager.neutral700,
                drawablePadding: 4.0.w,
                drawableEnd: BlocBuilder<ResendCodeCubit, ResendCodeInitial>(
                  builder: (context, state) {
                    if (state.statuses == CubitStatuses.loading) {
                      return MyStyle.loadingWidget(size: 36.0.r);
                    }
                    return TextButton(
                      onPressed: () => resendCodeCubit.resendCode(),
                      style: TextButton.styleFrom(minimumSize: Size(44.0.w, 44.0.h)),
                      child: DrawableText(
                        text: S.of(context).resend,
                        size: 14.0.sp,
                        fontWeight: .w700,
                        color: AppColorManager.primary600,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
          bottom: [
            BlocBuilder<OtpPasswordCubit, OtpPasswordInitial>(
              builder: (context, state) {
                return MyButton(
                  text: S.of(context).verify,
                  loading: state.statuses.loading,
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
            16.0.verticalSpace,
            AuthLink(
              text: S.of(context).backToLogin,
              onTap: () {
                AppSharedPreference.removePhone();
                Navigator.pushNamed(context, RouteName.login);
              },
            ),
          ],
        ),
      ),
    );
  }
}
