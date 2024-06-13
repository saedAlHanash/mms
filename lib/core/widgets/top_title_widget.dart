import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/widgets/my_card_widget.dart';

class TopTitleWidget extends StatelessWidget {
  const TopTitleWidget({
     super.key,
    required this.text,
    required this.icon,
    this.iconSize,
    this.safeArea,
  });

  final String text;
  final String icon;
  final double? iconSize;

  final bool? safeArea;

  @override
  Widget build(BuildContext context) {
    final iconSize = this.iconSize ?? 30.0.spMin;

    final iconWidget = ImageMultiType(url:
      icon,
      height: iconSize,
      width: iconSize,
      color: AppColorManager.grey,
    );

    final textWidget = DrawableText(
      text: text,
      color: AppColorManager.grey,
      fontFamily: FontManager.cairoBold.name,
      size: 18.0.spMin,
    );
    return MyCardWidget(
      margin: EdgeInsets.symmetric(
          horizontal: 35.0.w,
          vertical: (safeArea ?? false)
              ? MediaQuery.of(context).viewPadding.top + 10.0.h
              : 0),
      padding: EdgeInsets.symmetric(vertical: 12.0.h, horizontal: 14.0.w),
      elevation: 3.0,
      cardColor: AppColorManager.lightGray,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [iconSize.horizontalSpace, textWidget, iconWidget],
      ),
    );
  }
}
