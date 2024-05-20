import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/circle_image_widget.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../data/response/attendee_response.dart';

class AttendeesListWidget extends StatelessWidget {
  const AttendeesListWidget({super.key, required this.attendees});

  final List<Attendee> attendees;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: attendees.length,
      itemBuilder: (context, i) {
        final item = attendees[i];
        return ListTile(
          leading: CircleImageWidget(
            url: item.party.personalPhoto,
            size: 55.0.r,
          ),
          title: DrawableText(
            text: item.party.name,
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
    );
  }
}
