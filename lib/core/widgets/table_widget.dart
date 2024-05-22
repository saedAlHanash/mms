import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/widgets/my_card_widget.dart';

class MyTableWidget extends StatelessWidget {
  const MyTableWidget({
     super.key,
    required this.children,
    required this.title,
  });

  final Map<String, String> children;
  final String title;

  @override
  Widget build(BuildContext context) {
    final divider = SizedBox(
      height: 20.0,
      child: VerticalDivider(thickness: 1.0.w),
    );
    const dividerH = Divider(height: 0.0);

    List<Widget> items = [];

    children.forEach((key, value) {
      final row = Row(
        children: [
          10.0.horizontalSpace,
          SizedBox(
            width: 100.0.w,
            child: DrawableText(
              text: key,
              color: AppColorManager.black,
              textAlign: TextAlign.center,
            ),
          ),
          divider,
          Expanded(
            child: DrawableText(
              text: value,
              textAlign: TextAlign.center,
              color: AppColorManager.black,
            ),
          )
        ],
      );
      items.add(row);
      items.add(dividerH);
    });

    items.removeAt(items.length - 1);

    return MyCardWidget(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Ink(
            color: AppColorManager.mainColor,
            child: DrawableText(
              matchParent: true,
              textAlign: TextAlign.center,
              text: title,
              color: AppColorManager.whit,
            ),
          ),
          Column(children: items),
        ],
      ),
    );
  }
}