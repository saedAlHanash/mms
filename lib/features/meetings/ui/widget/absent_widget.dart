import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/util/snack_bar_message.dart';

import '../../../../core/strings/enum_manager.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../../generated/l10n.dart';
import '../../bloc/add_absence_cubit/add_absence_cubit.dart';
import '../../bloc/meeting_cubit/meeting_cubit.dart';

class AbsentWidget extends StatelessWidget {
  const AbsentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeetingCubit, MeetingInitial>(
      builder: (context, state) {
        if (state.result.status != MeetingStatus.scheduled) {
          return 0.0.verticalSpace;
        }

        if (state.result.hasRequestAbsence) {
          return DrawableText(
            text: 'you request you as an absent member ',
            matchParent: true,
            padding: const EdgeInsets.all(20.0).r,
            textAlign: TextAlign.center,
            size: 20.0.sp,
            color: Colors.red,
          );
        }

        return Padding(
          padding: const EdgeInsets.all(20.0).r,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DrawableText(
                textAlign: TextAlign.center,
                text: S.of(context).requestAbsence,
                size: 18.0.sp,
              ),
              BlocBuilder<AddAbsenceCubit, AddAbsenceInitial>(
                builder: (context, state) {
                  return MyButton(
                    onTap: () {
                      NoteMessage.showCheckDialog(
                        context,
                        text: 'Are you sure',
                        textButton: 'Yes',
                        image: 0.0.verticalSpace,
                        onConfirm: () {
                          context.read<AddAbsenceCubit>().addAbsence();
                        },
                      );
                    },
                    loading: state.statuses.loading,
                    width: .35.sw,
                    color: Colors.red,
                    text: 'I will be absent',
                    startIcon: ImageMultiType(
                      url: Icons.cancel_outlined,
                      color: Colors.white,
                      width: 20.0.r,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
