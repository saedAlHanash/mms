import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../strings/app_color_manager.dart';

class TextWithListDote extends StatelessWidget {
  const TextWithListDote(
      {Key? key, this.textWidget, this.matchParent, this.color, this.text = ''})
      : super(key: key);

  final Widget? textWidget;
  final String text;
  final bool? matchParent;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    if (textWidget == null && text.isEmpty) {
      return 0.0.verticalSpace;
    }
    // final widget = textWidget ??
    //     DrawableText(
    //       text: text,
    //       size: 18.0.spMin,
    //       color: AppColorManager.textColor,
    //     );
    return SizedBox(
      width: (matchParent ?? false) ? 1.0.sw : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          DrawableText(
            text: '.',
            size: 40.0.spMin,
            padding: const EdgeInsets.only(left: 10.0, right: 5.0).w,
            color: color ?? AppColorManager.mainColor,
          ),
          Expanded(
            child: DrawableText(
              text: text,
              size: 20.0.spMin,
              fontFamily: FontManager.cairoBold.name,
              color: AppColorManager.black,
            ),
          ),
        ],
      ),
    );
  }
}
