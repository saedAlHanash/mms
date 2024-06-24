import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/circle_image_widget.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../data/response/member_response.dart';

class MembersListWidget extends StatelessWidget {
  const MembersListWidget({super.key, required this.members});

  final List<Member> members;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: members.length,
      itemBuilder: (context, i) {
        final item = members[i];
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
            text: item.membershipType.name,
            color: item.membershipType.getColor,
            fontFamily: FontManager.cairoBold.name,
          ),
          trailing: item.isMe
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
