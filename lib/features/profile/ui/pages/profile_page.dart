import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/widgets/app_bar/app_bar_widget.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/core/widgets/my_text_form_widget.dart';

import '../../../../core/strings/enum_manager.dart';
import '../../../../core/widgets/item_image_create.dart';
import '../../../../core/widgets/spinner_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../auth/bloc/get_me_cubit/get_me_cubit.dart';
import '../../../files/bloc/upload_file_cubit/upload_file_cubit.dart';
import '../../bloc/update_profile_cubit/update_profile_cubit.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UpdateProfileCubit get updateCubit => context.read<UpdateProfileCubit>();

  UpdateProfileInitial get updateState =>
      context.read<UpdateProfileCubit>().state;

  final bDateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    bDateController.text = updateState.request.dob?.formatDate ?? '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UpdateProfileCubit, UpdateProfileInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            context.read<LoggedPartyCubit>().getLoggedParty(newData: true);
            Navigator.pop(context);
          },
        ),
        BlocListener<LoggedPartyCubit, LoggedPartyInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) => updateCubit.setParty(),
        ),
        BlocListener<FileCubit, FileInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            updateState.request.personalPhoto = state.result.fileName;
            updateCubit.updateProfile();
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBarWidget(titleText: S.of(context).profile),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40.0).r,
          child: Form(
            key: _formKey,
            child: BlocBuilder<UpdateProfileCubit, UpdateProfileInitial>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StatefulBuilder(builder: (context, setState) {
                      return ItemImageCreate(
                        height: 150.0.r,
                        image: updateState.request.profileImageUrl.getImage,
                        onLoad: (bytes) {
                          setState(() => updateState
                              .request.profileImageUrl.fileBytes = bytes);
                        },
                      );
                    }),
                    20.0.verticalSpace,
                    //name
                    MyTextFormOutLineWidget(
                      validator: (p0) => updateCubit.validateName,
                      initialValue: updateState.request.firstName,
                      label: S.of(context).firstName,
                      onChanged: (val) => updateCubit.setFirstName = val,
                    ),
                    MyTextFormOutLineWidget(
                      validator: (p0) => updateCubit.validateName,
                      initialValue: updateState.request.lastName,
                      label: S.of(context).lastName,
                      onChanged: (val) => updateCubit.setLastName = val,
                    ),
                    MyTextFormOutLineWidget(
                      validator: (p0) => updateCubit.validateName,
                      initialValue: updateState.request.middleName,
                      label: S.of(context).middleName,
                      onChanged: (val) => updateCubit.setMiddleName = val,
                    ),

                    MyTextFormOutLineWidget(
                      validator: (p0) => updateCubit.validateEmail,
                      initialValue: updateState.request.email,
                      label: S.of(context).email,
                      onChanged: (val) => updateCubit.setEmail = val,
                    ),

                    SpinnerWidget(
                      items: GenderEnum.values.getSpinnerItems(
                        selectedId: updateState.request.gender?.index,
                      ),
                      onChanged: (item) => updateCubit.setGender = item.item,
                      hintText:
                          '${S.of(context).choosing} ${S.of(context).gender}',
                    ),
                    20.0.verticalSpace,

                    //birthdate
                    MyTextFormOutLineWidget(
                      validator: (p0) => updateCubit.validateBirthday,
                      controller: bDateController,
                      enable: false,
                      label: S.of(context).birthday,
                      onTap: () async {
                        final datePicked = await showDatePicker(
                            context: context,
                            initialDate:
                                updateState.request.dob ?? DateTime(2000),
                            lastDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            initialDatePickerMode: DatePickerMode.year,
                            initialEntryMode: DatePickerEntryMode.calendarOnly);
                        if (datePicked == null) return;
                        updateCubit.setBirthday = datePicked;
                        bDateController.text = datePicked.formatDate;
                      },
                      iconWidgetLift:
                          const ImageMultiType(url: Icons.date_range),
                    ),
                    //location
                    MyTextFormOutLineWidget(
                      validator: (p0) => updateCubit.validateLocation,
                      initialValue: updateState.request.address,
                      label: S.of(context).location,
                      onChanged: (val) => updateCubit.setAddress = val,
                    ),

                    BlocBuilder<FileCubit, FileInitial>(
                      builder: (context, fState) {
                        return BlocBuilder<UpdateProfileCubit,
                            UpdateProfileInitial>(
                          builder: (context, state) {
                            return MyButton(
                              loading: state.statuses.loading ||
                                  fState.statuses.loading,
                              text: S.of(context).update,
                              onTap: () {
                                if (!_formKey.currentState!.validate()) return;
                                if (updateState
                                        .request.profileImageUrl.fileBytes !=
                                    null) {
                                  context.read<FileCubit>().uploadFile(
                                        request:
                                            updateState.request.profileImageUrl,
                                      );
                                } else {
                                  updateCubit.updateProfile();
                                }
                              },
                            );
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
