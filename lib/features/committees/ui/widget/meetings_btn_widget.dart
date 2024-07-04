import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/api_manager/request_models/command.dart';
import 'package:mms/generated/assets.dart';
import 'package:mms/router/app_router.dart';

import '../../../../core/app/app_provider.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../bloc/committee_cubit/committee_cubit.dart';

class DrawerMeetingsBtnWidget extends StatelessWidget {
  const DrawerMeetingsBtnWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.directional(
      end: 0,
      textDirection: AppProvider.getDirection,
      top: 130.0.h,
      width: 80.0.w,
      height: 45.0.h,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            RouteName.calenderMeetings,
            arguments: FilterRequest(
              filters: [
                Filter(
                  name: 'committeeId',
                  val: context.read<CommitteeCubit>().state.uuid,
                  operation: FilterOperation.equals,
                ),
                Filter(
                  name: 'status',
                  val: MeetingStatus.planned.index.toString(),
                  operation: FilterOperation.notEqual,
                ),
              ],
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(10.0).r,
          decoration: MyStyle.directionalDecoration,
          child: const ImageMultiType(
            url: Assets.iconsCalendar,
          ),
        ),
      ),
    );
  }
}
