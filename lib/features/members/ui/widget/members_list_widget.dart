import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/circle_image_widget.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../../../core/widgets/my_card_widget.dart';
import '../../data/response/member_response.dart';

class MembersListWidget extends StatelessWidget {
  const MembersListWidget({super.key, required this.members});

  final List<Member> members;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.0.h,
      width: 1.0.sw,
      child: ListView.builder(
        itemCount: members.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, i) {
          final member = members[i];
          return MyCardWidget(
            cardColor: Colors.white,
            elevation: 7.0,
            child: SizedBox(
              width: 0.23.sw,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleImageWidget(
                    url: member.party.personalPhoto,
                    size: 75.0.r,
                  ),
                  10.0.verticalSpace,
                  DrawableText(text: member.party.name),
                  5.0.verticalSpace,
                  DrawableText(
                    text: member.membershipType.getName,
                    color: member.membershipType.getColor,
                    fontFamily: FontManager.cairoBold.name,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
