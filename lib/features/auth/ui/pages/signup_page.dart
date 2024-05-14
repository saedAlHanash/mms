import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/core/util/my_style.dart';
import 'package:mms/core/widgets/app_bar/app_bar_widget.dart';
import 'package:mms/core/widgets/item_image_create.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/core/widgets/my_text_form_widget.dart';
import 'package:mms/core/widgets/spinner_widget.dart';
import 'package:mms/features/auth/ui/widget/my_location_widget.dart';
import 'package:mms/router/app_router.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../generated/l10n.dart';
import '../../bloc/signup_cubit/signup_cubit.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  SignupCubit get signupCubit => context.read<SignupCubit>();

  SignupInitial get signupState => context.read<SignupCubit>().state;

  final locationController = TextEditingController();
  final bDateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupInitial>(
      listenWhen: (p, c) => c.statuses.done,
      listener: (context, state) {
        Navigator.pushNamedAndRemoveUntil(
            context, RouteName.confirmCode, (route) => false);
      },
      child: Scaffold(
        appBar: AppBarWidget(titleText: S.of(context).createAccount),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40.0).r,
          child: Form(
            key: _formKey,
            child: BlocBuilder<SignupCubit, SignupInitial>(
              builder: (context, state) {

                locationController.text =
                    signupState.request.locationName ?? '';
                bDateController.text =
                    signupState.request.birthday?.formatDate ?? '';

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    19.verticalSpace,
                    DrawableText(text: S.of(context).addCorectData),
                    50.verticalSpace,
                    //name
                    MyTextFormOutLineWidget(
                      validator: (p0) => signupCubit.validateName,
                      controller:
                          TextEditingController(text: signupState.request.name),
                      label: S.of(context).name,
                      onChanged: (val) => signupCubit.setName = val,
                    ),
                    //location
                    MyTextFormOutLineWidget(
                      validator: (p0) => signupCubit.validateLocation,
                      controller: locationController,
                      label: S.of(context).location,
                      onChanged: (val) =>
                          signupCubit.setLocation(locationName: val),
                      iconWidgetLift:
                          MyLocationWidget(controller: locationController),
                    ),
                    SpinnerWidget(
                      items: GenderEnum.values.getSpinnerItems(
                        selectedId: signupState.request.gender?.index,
                      ),
                      onChanged: (item) => signupCubit.setGender = item.item,
                      hintText:
                          '${S.of(context).choosing} ${S.of(context).gender}',
                    ),
                    20.0.verticalSpace,
                    20.0.verticalSpace,
                    //birthdate
                    MyTextFormOutLineWidget(
                      validator: (p0) => signupCubit.validateBirthday,
                      controller: bDateController,
                      enable: false,
                      label: S.of(context).birthday,
                      onTap: () async {
                        final datePicked = await showDatePicker(
                            context: context,
                            initialDate:
                                signupState.request.birthday ?? DateTime(2000),
                            lastDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            initialDatePickerMode: DatePickerMode.year,
                            initialEntryMode: DatePickerEntryMode.calendarOnly);
                        if (datePicked == null) return;
                        signupCubit.setBirthday = datePicked;
                        bDateController.text = datePicked.formatDate;
                      },
                      iconWidgetLift:
                          const ImageMultiType(url: Icons.date_range),
                    ),
                    // رقم الهاتف
                    MyTextFormOutLineWidget(
                      validator: (p0) => signupCubit.validatePhone,
                      controller: TextEditingController(
                          text: signupState.request.phone),
                      keyBordType: TextInputType.phone,
                      label: S.of(context).phoneNumber,
                      onChanged: (val) => signupCubit.setPhone = val,
                    ),
                    // كلمة السر
                    MyTextFormOutLineWidget(
                      validator: (p0) => signupCubit.validatePassword,
                      label: S.of(context).password,
                      controller: TextEditingController(
                          text: signupState.request.password),
                      obscureText: true,
                      onChanged: (val) => signupCubit.setPassword = val,
                      textDirection: TextDirection.ltr,
                    ),
                    // كلمة السر
                    MyTextFormOutLineWidget(
                      validator: (p0) => signupCubit.validateRePassword,
                      label: S.of(context).rePassword,
                      obscureText: true,
                      controller: TextEditingController(
                          text: signupState.request.rePassword),
                      onChanged: (val) => signupCubit.setRePassword = val,
                      textDirection: TextDirection.ltr,
                    ),
                    StatefulBuilder(
                      builder: (context, mState) {
                        return Column(
                          children: [
                            ItemFiledCreate(
                              image: signupState.request.identityImage.getImage,
                              name: S.of(context).identityImage,
                              onLoad: (bytes) {
                                mState(
                                    () => signupCubit.setIdentityImage = bytes);
                              },
                            ),
                            ItemFiledCreate(
                              image:
                                  signupState.request.profileImageUrl.getImage,
                              name: S.of(context).profileImage,
                              onLoad: (bytes) {
                                mState(
                                  () {
                                    signupCubit.setProfileImage = bytes;
                                  },
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),
                    10.0.verticalSpace,
                    BlocBuilder<SignupCubit, SignupInitial>(
                      builder: (context, state) {
                        if (state.statuses.loading) {
                          return MyStyle.loadingWidget();
                        }
                        return MyButton(
                          text: S.of(context).signUp,
                          onTap: () {
                            if (!_formKey.currentState!.validate()) return;
                            signupCubit.signup();
                          },
                        );
                      },
                    ),
                    40.0.verticalSpace,
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
