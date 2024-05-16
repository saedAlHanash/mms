import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/generated/assets.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/app_color_manager.dart';

class DrawerBtnWidget extends StatefulWidget {
  const DrawerBtnWidget({super.key});

  @override
  State<DrawerBtnWidget> createState() => _DrawerBtnWidgetState();
}

class _DrawerBtnWidgetState extends State<DrawerBtnWidget> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      top: 60.0.h,
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
