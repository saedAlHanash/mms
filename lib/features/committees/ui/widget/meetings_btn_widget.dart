import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/api_manager/request_models/command.dart';
import 'package:mms/generated/assets.dart';
import 'package:mms/router/app_router.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../bloc/committee_cubit/committee_cubit.dart';

class DrawerMeetingsBtnWidget extends StatelessWidget {
  const DrawerMeetingsBtnWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      top: 150.0.h,
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
                  val: MeetingStatus.planned.realName,
                  operation: FilterOperation.notEqual,
                ),
              ],
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(10.0).r,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(10.0.r),
            ),
            color: AppColorManager.mainColor,
          ),
          child: const ImageMultiType(
            url: Assets.iconsCalendar,
          ),
        ),
      ),
    );
  }
}
