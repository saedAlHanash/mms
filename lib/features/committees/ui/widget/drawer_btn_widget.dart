import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/generated/assets.dart';

import '../../../../core/strings/app_color_manager.dart';

class DrawerMemberBtnWidget extends StatefulWidget {
  const DrawerMemberBtnWidget({super.key});

  @override
  State<DrawerMemberBtnWidget> createState() => _DrawerMemberBtnWidgetState();
}

class _DrawerMemberBtnWidgetState extends State<DrawerMemberBtnWidget> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      top: 90.0.h,
      width: 80.0.w,
      height: 45.0.h,
      child: InkWell(
        onTap: () => Scaffold.of(context).openEndDrawer(),
        child: Container(
          padding: const EdgeInsets.all(10.0).r,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(10.0.r),
            ),
            color: AppColorManager.mainColor,
          ),
          child: const ImageMultiType(
            url: Assets.iconsMembers,
          ),
        ),
      ),
    );
  }
}

class ActionBarMemberWidget extends StatelessWidget {
  const ActionBarMemberWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Scaffold.of(context).openEndDrawer();
      },
      child: Container(
        padding: const EdgeInsets.all(12.0).r,
        margin: const EdgeInsets.symmetric(horizontal: 20.0).r,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColorManager.mainColor,
        ),
        child: const ImageMultiType(
          url: Assets.iconsMembers,
        ),
      ),
    );
  }
}
