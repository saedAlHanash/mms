import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mms/core/widgets/app_bar/app_bar_widget.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/core/widgets/my_text_form_widget.dart';
import 'package:mms/features/auth/bloc/forget_password_cubit/forget_password_cubit.dart';
import 'package:mms/features/auth/ui/widget/auth_layout.dart';
import 'package:mms/generated/assets.dart';
import 'package:mms/generated/l10n.dart';
import 'package:mms/router/app_router.dart';

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
        appBar: AppBarWidget(titleText: S.of(context).forgetPassword),
        body: AuthPageLayout(
          content: [
            AuthHeader(
              icon: Assets.iconsKey,
              title: S.of(context).forgetPasswordTitle,
              subtitle: S.of(context).forgetPasswordSubtitle,
            ),
            20.0.verticalSpace,
            AuthInfoBox(text: S.of(context).doneSendCode),
            24.0.verticalSpace,
            MyTextFormOutLineWidget(
              icon: Assets.iconsPhone,
              keyBordType: TextInputType.phone,
              controller: forgetPasswordState.phoneC,
              label: S.of(context).phoneNumber,
              textDirection: .ltr,
            ),
          ],
          bottom: [
            BlocBuilder<ForgetPasswordCubit, ForgetPasswordInitial>(
              builder: (_, state) {
                return MyButton(
                  text: S.of(context).continueTo,
                  loading: state.loading,
                  onTap: () => forgetPasswordCubit.forgetPassword(),
                );
              },
            ),
            16.0.verticalSpace,
            AuthLink(
              leading: S.of(context).rememberPassword,
              text: S.of(context).login,
              onTap: () => Navigator.pushReplacementNamed(context, RouteName.login),
            ),
          ],
        ),
      ),
    );
  }
}
