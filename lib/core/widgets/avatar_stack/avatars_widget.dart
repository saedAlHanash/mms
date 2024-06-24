import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mms/core/widgets/avatar_stack/src/avatar_stack.dart';

import '../../../generated/assets.dart';

class AvatarsWidget extends StatelessWidget {
  const AvatarsWidget({super.key, required this.avatars});

  final List<dynamic> avatars;

  @override
  Widget build(BuildContext context) {
    return AvatarStack(
      infoWidgetBuilder: (surplus) {
        return Container(
          height: 30.0.r,
          width: 30.0.r,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: AssetImage(Assets.imagesAvatar))),
          alignment: Alignment.center,
          child: DrawableText(
            text: '+$surplus',
            color: Colors.white,
            size: 22.0.sp,
            fontWeight: FontWeight.bold,
          ),
        );
      },
      avatars: avatars,
    );
  }
}
