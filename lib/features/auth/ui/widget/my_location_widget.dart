import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../../../core/util/my_style.dart';
import '../../../../generated/assets.dart';
import '../../../../services/location_service/my_location_cubit/my_location_cubit.dart';
import '../../bloc/signup_cubit/signup_cubit.dart';

class MyLocationWidget extends StatefulWidget {
  const MyLocationWidget({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<MyLocationWidget> createState() => _MyLocationWidgetState();
}

class _MyLocationWidgetState extends State<MyLocationWidget> {
  late final SignupCubit signupCubit;
  late final SignupInitial signupState;

  @override
  void initState() {
    signupCubit = context.read<SignupCubit>();
    signupState = signupCubit.state;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.0.r,
      width: 20.0.r,
      child: BlocConsumer<LocationServiceCubit, LocationServiceInitial>(
        listenWhen: (p, c) => c.statuses.done,
        listener: (context, state) {
          widget.controller.text = state.locationName;
          signupCubit.setLocation(
            location: state.result,
            locationName: state.locationName,
          );
        },
        builder: (context, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          return IconButton(
            icon: const ImageMultiType(url: Assets.iconsLocater),
            onPressed: () => context.read<LocationServiceCubit>().getMyLocation(),
          );
        },
      ),
    );
  }
}
