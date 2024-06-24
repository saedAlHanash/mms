import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/circle_image_widget.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/features/meetings/bloc/meeting_cubit/meeting_cubit.dart';
import 'package:mms/features/meetings/data/response/meetings_response.dart';

import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../data/response/attendee_response.dart';

class AttendeesListWidget extends StatelessWidget {
  const AttendeesListWidget({super.key, required this.meeting});

  final Meeting meeting;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          DrawableText.header(text: 'Attendees'),
          5.0.verticalSpace,
          Divider(height: 5.0.h),
          Expanded(
            child: ListView.builder(
              itemCount: meeting.attendeesList.length,
              itemBuilder: (context, i) {
                final item = meeting.attendeesList[i];
                return ListTile(
                  leading: CircleImageWidget(
                    url:  Assets.imagesAvatar,
                    size: 55.0.r,
                  ),
                  title: DrawableText(
                    text: item.fullName,
                    drawablePadding: 20.0.w,
                  ),
                  subtitle: DrawableText(
                    text: item.attendanceDate?.formatDate ?? '',
                    fontFamily: FontManager.cairoBold.name,
                  ),
                  trailing: item.partyId == AppProvider.getParty.id
                      ? const ImageMultiType(
                          url: Icons.person,
                          color: Colors.grey,
                        )
                      : null,
                );
              },
            ),
          ),
          if (meeting.guestsList.isNotEmpty) ...[
            DrawableText.header(text: 'Guests'),
            5.0.verticalSpace,
            Divider(height: 5.0.h),
            Expanded(
              child: ListView.builder(
                itemCount: meeting.guestsList.length,
                itemBuilder: (context, i) {
                  final item = meeting.guestsList[i];
                  return ListTile(
                    leading: CircleImageWidget(
                      url: Assets.imagesAvatar,
                      size: 55.0.r,
                    ),
                    title: DrawableText(
                      text: item.name,
                      drawablePadding: 20.0.w,
                    ),
                    subtitle: DrawableText(
                      text: item.phone,
                      fontFamily: FontManager.cairoBold.name,
                    ),
                  );
                },
              ),
            ),
          ],
          if (meeting.guestSuggestions.isNotEmpty) ...[
            DrawableText.header(text: S.of(context).suggestedGuests),
            5.0.verticalSpace,
            Divider(height: 5.0.h),
            Expanded(
              child: ListView.builder(
                itemCount: meeting.guestSuggestions.length,
                itemBuilder: (context, i) {
                  final item = meeting.guestSuggestions[i];
                  return ListTile(
                    leading: CircleImageWidget(
                      url: Assets.imagesAvatar,
                      size: 55.0.r,
                    ),
                    title: DrawableText(
                      text: item.name,
                      drawablePadding: 20.0.w,
                    ),
                    subtitle: DrawableText(
                      text: item.phone,
                      fontFamily: FontManager.cairoBold.name,
                    ),
                  );
                },
              ),
            ),
          ],
          Padding(
            padding: const EdgeInsets.all(20.0).w,
            child: MyButton(
              startIcon: const ImageMultiType(
                url: Icons.add,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.pushNamed(context, RouteName.addGuest).then((value) {
                  if (value is bool && value) {
                    context.read<MeetingCubit>().getMeeting(newData: true);
                  }
                });
              },
              text: S.of(context).suggestingGuest,
            ),
          ),
        ],
      ),
    );
  }
}
