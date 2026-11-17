import 'package:go_router/go_router.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/widgets/app_bar/app_bar_widget.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/core/widgets/my_text_form_widget.dart';
import 'package:mms/features/meetings/bloc/add_guest_cubit/add_guest_cubit.dart';
import 'package:mms/generated/l10n.dart';

class AddGuestPage extends StatefulWidget {
  const AddGuestPage({super.key});

  @override
  State<AddGuestPage> createState() => _AddGuestPageState();
}

class _AddGuestPageState extends State<AddGuestPage> {
  AddGuestCubit get cubit => context.read<AddGuestCubit>();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddGuestCubit, AddGuestInitial>(
      listenWhen: (p, c) => c.done,
      listener: (context, state) {
        context.pop(true);
      },
      child: Scaffold(
        appBar: AppBarWidget(titleText: S.of(context).suggestedGuest),
        body: Form(
          key: _formKey,
          child: SafeArea(
            top: false,
            child: Column(
              crossAxisAlignment: .stretch,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(20.0.w, 16.0.h, 20.0.w, 24.0.h),
                    child: Column(
                      crossAxisAlignment: .stretch,
                      children: [
                        // Meeting context card.
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 10.0.h),
                          decoration: BoxDecoration(
                            color: AppColorManager.neutral25,
                            border: Border.all(color: AppColorManager.neutral50),
                            borderRadius: BorderRadius.circular(10.0.r),
                          ),
                          child: Column(
                            crossAxisAlignment: .start,
                            children: [
                              DrawableText(
                                text: S.of(context).suggestedFor,
                                size: 12.0.sp,
                                color: AppColorManager.neutral500,
                              ),
                              DrawableText(
                                text: AppProvider.getCurrentMeeting.title,
                                size: 14.0.sp,
                                fontWeight: .w600,
                                color: AppColorManager.neutral900,
                              ),
                            ],
                          ),
                        ),
                        20.0.verticalSpace,
                        Row(
                          crossAxisAlignment: .start,
                          children: [
                            Expanded(
                              child: MyTextFormOutLineWidget(
                                onChanged: (p0) => cubit.setFName = p0,
                                label: S.of(context).firstName,
                                validator: (p0) => cubit.validateName,
                              ),
                            ),
                            12.0.horizontalSpace,
                            Expanded(
                              child: MyTextFormOutLineWidget(
                                onChanged: (p0) => cubit.setLName = p0,
                                label: S.of(context).lastName,
                                validator: (p0) => cubit.validateName,
                              ),
                            ),
                          ],
                        ),
                        14.0.verticalSpace,
                        MyTextFormOutLineWidget(
                          onChanged: (p0) => cubit.setEmail = p0,
                          label: S.of(context).email,
                          keyBordType: TextInputType.emailAddress,
                          textDirection: .ltr,
                          validator: (p0) => cubit.validateEmail,
                        ),
                        14.0.verticalSpace,
                        MyTextFormOutLineWidget(
                          onChanged: (p0) => cubit.setPhone = p0,
                          label: S.of(context).phoneNumber,
                          keyBordType: TextInputType.phone,
                          textDirection: .ltr,
                          validator: (p0) => cubit.validatePhone,
                        ),
                        14.0.verticalSpace,
                        MyTextFormOutLineWidget(
                          onChanged: (p0) => cubit.setCompany = p0,
                          label: S.of(context).company,
                          validator: (p0) => cubit.validateCompany,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.0.w, 0, 20.0.w, 32.0.h),
                  child: Column(
                    mainAxisSize: .min,
                    crossAxisAlignment: .stretch,
                    children: [
                      DrawableText(
                        text: S.of(context).addGuestHint,
                        size: 13.0.sp,
                        color: AppColorManager.neutral500,
                        textAlign: .center,
                      ),
                      12.0.verticalSpace,
                      BlocBuilder<AddGuestCubit, AddGuestInitial>(
                        builder: (context, state) {
                          return MyButton(
                            width: double.infinity,
                            loading: state.statuses.loading,
                            onTap: () {
                              if (!_formKey.currentState!.validate()) return;
                              context.read<AddGuestCubit>().getAddGuest();
                            },
                            text: S.of(context).sendSuggestion,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
