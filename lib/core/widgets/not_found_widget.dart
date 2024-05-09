import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

class NotFoundWidget extends StatelessWidget {
  const NotFoundWidget({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);
  final String text;
  final dynamic icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0).r,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ImageMultiType(
              url: icon,
              height: 250.0.spMin,
              width: 250.0.spMin,
            ),
            10.0.verticalSpace,
            DrawableText(
              text: text,
              matchParent: true,
              textAlign: TextAlign.center,
              color: Colors.black,
              size: 20.0.spMin,
            )
          ],
        ),
      ),
    );
  }
}
