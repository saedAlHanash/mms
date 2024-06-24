import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/widgets/app_bar/app_bar_widget.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/core/widgets/my_text_form_widget.dart';
import 'package:mms/features/meetings/bloc/add_guest_cubit/add_guest_cubit.dart';

import '../../../../generated/l10n.dart';

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
      listenWhen: (p, c) => c.statuses.done,
      listener: (context, state) {
        Navigator.pop(context, true);
      },
      child: Scaffold(
        appBar: AppBarWidget(titleText: S.of(context).suggestedGuest),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(40.0).r,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                MyTextFormOutLineWidget(
                  onChanged: (p0) => cubit.setFName = p0,
                  label: S.of(context).firstName,
                  icon: Icons.drive_file_rename_outline,
                  validator: (p0) => cubit.validateName,
                ),
                MyTextFormOutLineWidget(
                  onChanged: (p0) => cubit.setLName = p0,
                  label: S.of(context).lastName,
                  icon: Icons.drive_file_rename_outline,
                  validator: (p0) => cubit.validateName,
                ),
                MyTextFormOutLineWidget(
                  onChanged: (p0) => cubit.setEmail = p0,
                  label: S.of(context).email,
                  icon: Icons.email_outlined,
                  keyBordType: TextInputType.emailAddress,
                  validator: (p0) => cubit.validateEmail,
                ),
                MyTextFormOutLineWidget(
                  onChanged: (p0) => cubit.setPhone = p0,
                  label: S.of(context).phoneNumber,
                  keyBordType: TextInputType.phone,
                  icon: Icons.phone,
                  validator: (p0) => cubit.validatePhone,
                ),
                MyTextFormOutLineWidget(
                  onChanged: (p0) => cubit.setCompany = p0,
                  label: S.of(context).company,
                  icon: Icons.home_outlined,
                  validator: (p0) => cubit.validateCompany,
                ),
                MyButton(
                  onTap: () {
                    if (!_formKey.currentState!.validate()) return;
                    context.read<AddGuestCubit>().getAddGuest();
                  },
                  text: S.of(context).done,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
